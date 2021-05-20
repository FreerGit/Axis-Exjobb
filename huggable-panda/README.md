# Intro
This showcases how to use wasmtime in c, and how to create
a Docker container to use on Axis cameras.

You probably have a better idea how to do packaging, but we simply run: acap-build -m manifest.json -a build/fibb.wasm -a runner-wasmtime .

So that we get the files needed in the same directory at runetime on the camera. 

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


## NOTES FOR ARMv7
Do not compile with makefile, the os will append compile options that does not work.
use:
clang runner-wasmtime.c -I wasmtime/include/ -L wasmtime/lib/ wasmtime/lib/libwasmtime.so -ldl -lpthread -lm -o runner-wasmtime
for example