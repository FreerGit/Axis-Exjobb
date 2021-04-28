#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <wasm.h>
#include <wasmtime.h>

int main()
{
  // Set up context
  wasm_engine_t *engine = wasm_engine_new();
  assert(engine != NULL);
  wasm_store_t *store = wasm_store_new(engine);
  assert(store != NULL);

  // Load wasm file
  FILE *file = fopen("build/optimized.wasm", "r");
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
  wasmtime_instance_new(store, module, &imports, &instance, &trap);
  if (instance == NULL)
  {
    printf("> Failed to instantiate!\n");
    return 1;
  }

  // Lookup exported function
  wasm_extern_vec_t externs;
  wasm_instance_exports(instance, &externs);
  // printf("%s", externs.data[0]);
  // return 0;
  // assert(externs.size == 1);
  wasm_func_t *gcd = wasm_extern_as_func(externs.data[0]);
  assert(gcd != NULL);

  // Call to gcd
  int a = 48;
  int b = 18;
  wasm_val_t params[2] = { WASM_I32_VAL(a), WASM_I32_VAL(b) };
  wasm_val_t results[1];
  wasm_val_vec_t params_vec = WASM_ARRAY_VEC(params);
  wasm_val_vec_t results_vec = WASM_ARRAY_VEC(results);

  wasmtime_error_t *error = wasmtime_func_call(gcd, &params_vec, &results_vec, &trap);

  if (error != NULL || trap != NULL)
  {
    printf("> Error while executing!\n");
    return 1;
  }
  assert(results[0].kind == WASM_I32);

  printf("gcd(%d, %d) = %d\n", a, b, results[0].of.i32);

  // Clean up after ourselves
  wasm_extern_vec_delete(&externs);
  wasm_instance_delete(instance);
  wasm_module_delete(module);
  wasm_store_delete(store);
  wasm_engine_delete(engine);
  return 0;
}
