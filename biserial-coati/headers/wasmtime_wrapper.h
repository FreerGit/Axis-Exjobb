#ifndef WASMTIME_WRAPPER_H_
#define WASMTIME_WRAPPER_H_
typedef struct instance_t
{
  wasm_engine_t *engine;
  wasm_store_t *store;
  wasm_module_t *module;
  wasm_extern_vec_t externs;
  wasm_instance_t *wasm_instance;
} instance_t;
void wrapper_instantiate_universal(char *filename, struct instance_t *inst);
void wrapper_instantiate_no_wasi(char *filename, struct instance_t *inst);
#endif