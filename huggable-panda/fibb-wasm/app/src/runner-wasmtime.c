#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <wasm.h>
#include <wasmtime.h>
#include <syslog.h>

static void exit_with_error(const char *message, wasmtime_error_t *error, wasm_trap_t *trap)
{
  fprintf(stderr, "error: %s\n", message);
  wasm_byte_vec_t error_message;
  if (error != NULL)
  {
    wasmtime_error_message(error, &error_message);
    wasmtime_error_delete(error);
  }
  else
  {
    wasm_trap_message(trap, &error_message);
    wasm_trap_delete(trap);
  }
  fprintf(stderr, "%.*s\n", (int)error_message.size, error_message.data);
  wasm_byte_vec_delete(&error_message);
  exit(1);
}

int main()
{
  // Set up context
  wasm_engine_t *engine = wasm_engine_new();
  assert(engine != NULL);
  wasm_store_t *store = wasm_store_new(engine);
  assert(store != NULL);

  // Load wasm file
  // Must be relative to execution location of file
  FILE *file = fopen("build/fibb.wasm", "r");
  if (!file)
  {
    printf("> Error loading file! %s\n", strerror(errno));
    return 1;
  }
  fseek(file, 0L, SEEK_END);
  size_t file_size = ftell(file);
  fseek(file, 0L, SEEK_SET);
  wasm_byte_vec_t wasm;
  wasm_byte_vec_new_uninitialized(&wasm, file_size);
  if (fread(wasm.data, file_size, 1, file) != 1)
  {
    printf("> Error loading module!\n");
    return 1;
  }
  fclose(file);

  // Compile and instantiate module
  wasm_module_t *module = NULL;
  wasmtime_module_new(engine, &wasm, &module);
  if (module == NULL)
  {
    printf("> Failed to compile module!\n");
    return 1;
  }
  wasm_byte_vec_delete(&wasm);

  wasm_trap_t *trap = NULL;
  wasm_instance_t *instance = NULL;
  wasm_extern_vec_t imports = WASM_EMPTY_VEC;
  wasmtime_error_t *errorInstance = wasmtime_instance_new(store, module, &imports, &instance, &trap);
  if (instance == NULL)
  {
    exit_with_error("failed to..", errorInstance, trap);
    printf("> Failed to instantiate!\n");
    return 1;
  }

  // Lookup exported function
  wasm_extern_vec_t externs;
  wasm_instance_exports(instance, &externs);
  // return 0;
  // assert(externs.size == 1);
  wasm_func_t *fibb = wasm_extern_as_func(externs.data[2]);
  assert(fibb != NULL);

  // Call to fibb
  wasm_val_t params[1] = {WASM_I32_VAL(40)};
  wasm_val_t results[1];
  wasm_val_vec_t params_vec = WASM_ARRAY_VEC(params);
  wasm_val_vec_t results_vec = WASM_ARRAY_VEC(results);

  wasmtime_error_t *error = wasmtime_func_call(fibb, &params_vec, &results_vec, &trap);

  if (error != NULL || trap != NULL)
  {
    printf("> Error while executing!\n");
    return 1;
  }
  assert(results[0].kind == WASM_I32);

  // openlog("fibbers", LOG_PID|LOG_CONS, LOG_USER);
  // syslog(LOG_DEBUG, "fibb(40) = %d", results[0].of.i32);
  // closelog();
  printf("fibb(40) = %d\n", results[0].of.i32);

  // Clean up after ourselves
  wasm_extern_vec_delete(&externs);
  wasm_instance_delete(instance);
  wasm_module_delete(module);
  wasm_store_delete(store);
  wasm_engine_delete(engine);
  return 0;
}
