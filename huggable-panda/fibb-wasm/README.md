# Intro
This showcases how to use wasmtime in c, and how to create
a Docker container to use on Axis cameras.

You probably have a better idea how to do packaging, but we simply run: acap-build -m manifest.json -a build/fibb.wasm -a runner-wasmtime .

So that we get the files needed in the same directory at runetime on the camera. 


# Compile to wasm object file and use it during linking phase
Download/install/setup emcc as per: https://emscripten.org/docs/getting_started/downloads.html

Then for example, create a C file with the implementation. This can be seen in src/fibb.c
Compile that to a wasm object file with: `emcc fibb.c -c`

Then it's normal, inludee the header file and call the functions.

(assuming you want IO capabilities in your program, wasi is needed. If you want to use wasm file in a wrapper then skip wasi parts)
Lastly compile the final executable with `emcc --target=wasm32-wasi --sysroot=path/to/wasi-sdk/sysroot fibb.o main_runner.c -o executable.wasm`

Then run it with `wasmer/wasmtime run executable.wasm`

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

# NOTES FOR US
Check `-s SHARE=1` for .so files!
