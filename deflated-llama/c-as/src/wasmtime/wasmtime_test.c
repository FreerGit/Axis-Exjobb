#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <wasm.h>
#include <wasmtime.h>
#include "wasmtime_wrapper.h"

int main()
{
  // Set up context
  instance_t instance;
  wrapper_instantiate_no_wasi("build/optimized.wasm", &instance);

  // Lookup exported function
  // printf("%s", externs.data[0]);
  // return 0;
  // assert(instance.externs.size == 1);
  wasm_func_t *gcd = wasm_extern_as_func(instance.externs.data[0]);
  wasm_func_t *adder = wasm_extern_as_func(instance.externs.data[1]);
  assert(gcd != NULL);
  assert(adder != NULL);

  // Call to gcd
  int a = 48;
  int b = 18;
  wasm_val_t params[2] = {WASM_I32_VAL(a), WASM_I32_VAL(b)};
  wasm_val_t results[1];
  wasm_val_vec_t params_vec = WASM_ARRAY_VEC(params);
  wasm_val_vec_t results_vec = WASM_ARRAY_VEC(results);
  wasm_trap_t *trap = NULL;
  wasmtime_error_t *error = wasmtime_func_call(gcd, &params_vec, &results_vec, &trap);
  printf("gcd(%d, %d) = %d\n", a, b, results[0].of.i32);
  error = wasmtime_func_call(adder, &params_vec, &results_vec, &trap);
  printf("add(%d, %d) = %d\n", a, b, results[0].of.i32);

  if (error != NULL || trap != NULL)
  {
    printf("> Error while executing!\n");
    // return 1;
  }
  assert(results[0].kind == WASM_I32);

  // Clean up after ourselves
  wasm_extern_vec_delete(&instance.externs);
  wasm_instance_delete(instance.wasm_instance);
  wasm_module_delete(instance.module);
  wasm_store_delete(instance.store);
  wasm_engine_delete(instance.engine);
  return 0;
}
