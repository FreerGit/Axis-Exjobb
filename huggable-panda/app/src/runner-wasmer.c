#include <stdio.h>
#include "wasmer.h"
#include <assert.h>
#include <stdint.h>
#include <syslog.h>

int main()
{
    // Read the Wasm file bytes.
    FILE *file = fopen("build/fibb.wasm", "r");
    fseek(file, 0, SEEK_END);
    long len = ftell(file);
    uint8_t *bytes = malloc(len);
    fseek(file, 0, SEEK_SET);
    fread(bytes, 1, len, file);
    fclose(file);
 
    // Prepare the imports.
    wasmer_import_t imports[] = {};
 
    // Instantiate!
    wasmer_instance_t *instance = NULL;
    wasmer_result_t instantiation_result = wasmer_instantiate(&instance, bytes, len, imports, 0);
 
    assert(instantiation_result == WASMER_OK);
 
    // Let's call a function.
    // Start by preparing the arguments.
 
    // Value of argument #1 is `7i32`.
    wasmer_value_t argument_one;
    argument_one.tag = WASM_I32;
    argument_one.value.I32 = 40;
 
 
    // Prepare the arguments.
    wasmer_value_t arguments[] = {argument_one};
 
    // Prepare the return value.
    wasmer_value_t result_one;
    wasmer_value_t results[] = {result_one};
 
    // Call the `sum` function with the prepared arguments and the return value.
    wasmer_result_t call_result = wasmer_instance_call(instance, "fibb", arguments, 1, results, 1);
 
    // Let's display the result.
    // printf("Call result:  %d\n", call_result);
    // printf("Result: %d\n", results[0].value.I32);

    openlog("fibbers", LOG_PID|LOG_CONS, LOG_USER);
    syslog(LOG_INFO, "fibb(40) = %d\n", results[0].value.I32);
    closelog();
    printf("fibb(40) = %d\n", results[0].value.I32);
    // `sum(7, 8) == 15`.
    assert(results[0].value.I32 == 102334155);
    assert(call_result == WASMER_OK);
 
    wasmer_instance_destroy(instance);
 
    return 0;
}
