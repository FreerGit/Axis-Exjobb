# Intro
This showcases how to use wasmtime in c, and how to create
a Docker container to use on Axis cameras.

# Compilation
## fibb.c -> fibb.wasm
```
clang --target=wasm32 --no-standard-libraries -Wl,--export-all -Wl,--no-entry -o build/fibb.wasm src/fibb.c
```

## main.c -> main
```
clang -I wasmtime/crates/c-api/include \
-I wasmtime/crates/c-api/wasm-c-api/include \
wasmtime/target/release/libwasmtime.a \
-o build/main src/main.c
```

## fibb.rs -> fibb.wasm
