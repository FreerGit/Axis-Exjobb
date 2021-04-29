#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <wasm.h>
#include <wasmtime.h>
#include <wasi.h>

static void exit_with_error(const char *message)
{
  fprintf(stderr, "> %s\n", message);
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
  FILE *file = fopen("src/wasmtime/startup.wasm", "r");
  if (!file)
    exit_with_error("Error loading file!");

  fseek(file, 0L, SEEK_END);
  size_t file_size = ftell(file);
  fseek(file, 0L, SEEK_SET);
  wasm_byte_vec_t wasm;
  wasm_byte_vec_new_uninitialized(&wasm, file_size);
  if (fread(wasm.data, file_size, 1, file) != 1)
    exit_with_error("Error loading module!");
  fclose(file);

  // Compile module
  wasm_module_t *module = NULL;
  wasmtime_module_new(engine, &wasm, &module);
  if (module == NULL)
    exit_with_error("Failed to compile module!");
  wasm_byte_vec_delete(&wasm);

  // Instantiate WASI
  wasi_config_t *wasi_config = wasi_config_new();
  assert(wasi_config);
  assert(wasi_config);
  wasi_config_inherit_argv(wasi_config);
  wasi_config_inherit_env(wasi_config);
  wasi_config_inherit_stdin(wasi_config);
  wasi_config_inherit_stdout(wasi_config);
  wasi_config_inherit_stderr(wasi_config);
  wasm_trap_t *trap = NULL;
  wasi_instance_t *wasi = wasi_instance_new(store, "wasi_snapshot_preview1", wasi_config, &trap);
  if (wasi == NULL)
    exit_with_error("Failed to instantiate WASI!");

  wasmtime_linker_t *linker = wasmtime_linker_new(store);
  wasmtime_error_t *error = wasmtime_linker_define_wasi(linker, wasi);
  if (error != NULL)
    exit_with_error("Failed to link to WASI!");

  // Instantiate the module
  wasm_name_t empty;
  wasm_name_new_from_string(&empty, "");
  wasm_instance_t *instance = NULL;
  error = wasmtime_linker_module(linker, &empty, module);
  if (error != NULL)
    exit_with_error("Failed to instantiate module!");

  // Run this house
  wasm_func_t *func;
  error = wasmtime_linker_get_default(linker, &empty, &func);
  if (error != NULL)
    exit_with_error("Failed to locate default export for module!");

  wasm_val_vec_t args_vec = WASM_EMPTY_VEC;
  wasm_val_vec_t results_vec = WASM_EMPTY_VEC;
  error = wasmtime_func_call(func, &args_vec, &results_vec, &trap);
  if (error != NULL)
    exit_with_error("Error calling default export!");

  // Clean up after ourselves
  wasm_name_delete(&empty);
  wasm_module_delete(module);
  wasm_store_delete(store);
  wasm_engine_delete(engine);
  return 0;
}
