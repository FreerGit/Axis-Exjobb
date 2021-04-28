#include <stdio.h>
#include "wasmer.h"
#include <assert.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
  FILE *file = fopen("../../build/optimized.wasm", "r");

  if (!file) {
	  printf("> Error loading module!\n");

	  return 1;
  }

  if (argc < 3) {
	  printf("> Too few arguments supplied!\n");
	  return 1;
  }

  if (argc > 3) {
	  printf("> Too many arguments supplied!\n");
	  return 1;
  }
  fseek(file, 0, SEEK_END);
  long len = ftell(file);
  uint8_t *bytes = malloc(len);
  fseek(file, 0, SEEK_SET);
  fread(bytes, 1, len, file);
  fclose(file);

  // prepare imports
  wasmer_import_t imports[] = {};

  // Instantiate!
  wasmer_instance_t *instance = NULL;
  wasmer_result_t instantiation_result = wasmer_instantiate(&instance, bytes, len, imports, 0);

  assert(instantiation_result == WASMER_OK);

  // Prepping arguments for wasm-call
  // First value, "a"
  wasmer_value_t arg_one;
  arg_one.tag = WASM_I32;
  arg_one.value.I32 = atoi(argv[1]);

  // Second value, "b"
  wasmer_value_t arg_two;
  arg_two.tag = WASM_I32;
  arg_two.value.I32 = atoi(argv[2]);

  // Prepping args
  wasmer_value_t arguments[] = {arg_one, arg_two};

  // Prepping return value
  wasmer_value_t result_one;
  wasmer_value_t results[] = {result_one};

  // Call gcd with prepped args and return_val
  wasmer_result_t call_result
    = wasmer_instance_call(instance, "gcd", arguments, 2, results, 1);

  printf("Call result: %d\n", call_result);
  printf("GCD of %d and %d is %d\n", arg_one.value.I32, arg_two.value.I32, results[0].value.I32);

  // asserts that everything went well
  assert(call_result == WASMER_OK);

  wasmer_instance_destroy(instance);

  return 0;
}