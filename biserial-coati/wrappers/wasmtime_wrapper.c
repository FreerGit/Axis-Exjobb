#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <wasm.h>
#include <wasmtime.h>
#include <wasi.h>
#include "wasmtime_wrapper.h"

static void exit_with_error(const char *message, wasmtime_error_t *error, wasm_trap_t *trap);

// This is the same independent of the wasm-files characteristics
void wrapper_instantiate_universal(char *filename, instance_t *inst)
{
  // Set up context
  inst->engine = wasm_engine_new();
  assert(inst->engine != NULL);
  inst->store = wasm_store_new(inst->engine);
  assert(inst->store != NULL);

  // Load wasm file
  FILE *file = fopen(filename, "r");
  if (!file)
  {
    printf("> Error loading file! %s\n", strerror(errno));
    exit(1);
  }
  fseek(file, 0L, SEEK_END);
  size_t file_size = ftell(file);
  fseek(file, 0L, SEEK_SET);

  wasm_byte_vec_t wasm;
  wasm_byte_vec_new_uninitialized(&wasm, file_size);
  if (fread(wasm.data, file_size, 1, file) != 1)
  {
    printf("> Error loading module!\n");
    exit(1);
  }
  fclose(file);

  // Compile and instantiate module
  inst->module = NULL;
  wasmtime_error_t *error = wasmtime_module_new(inst->engine, &wasm, &inst->module);
  if (error != NULL)
    exit_with_error("Failed to compile module!", error, NULL);
  wasm_byte_vec_delete(&wasm);
}

void wrapper_instantiate_no_wasi(char *filename, instance_t *inst)
{
  wrapper_instantiate_universal(filename, inst);

  wasm_trap_t *trap = NULL;
  inst->wasm_instance = NULL;
  // wasm_instance_t *instance = NULL;
  wasm_extern_vec_t imports = WASM_EMPTY_VEC;
  wasmtime_error_t *error = wasmtime_instance_new(inst->store, inst->module, &imports, &inst->wasm_instance, &trap);
  if (inst->wasm_instance == NULL)
    exit_with_error("Failed to instantiate!", error, trap);
  // Lookup exported function
  wasm_extern_vec_t externs;
  wasm_instance_exports(inst->wasm_instance, &inst->externs);
}

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