#ifndef WASMTIME_WRAPPER_H_
#define WASMTIME_WRAPPER_H_
#pragma once
typedef struct instance_t
{
  wasm_engine_t *engine;
  wasm_store_t *store;
  wasm_module_t *module;
  wasm_extern_vec_t externs;
  wasm_instance_t *wasm_instance;
  wasi_instance_t *wasi_instance;
  wasm_name_t name;
} instance_t;
// Instantiation functions
void wrapper_instantiate_universal(char *filename, instance_t *inst);
void wrapper_instantiate_no_wasi(char *filename, instance_t *inst);
void wrapper_instantiate_wasi(char *filename, instance_t *inst);

// Call functions
void wrapper_call_default(instance_t *inst);

// Clean up function
void wrapper_clean_up(instance_t *inst);
#endif