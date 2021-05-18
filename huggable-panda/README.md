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



## MONDAY
Executing c program from c program may not output to the same shell, log works in main_wasmtime 
alternative to system()??


popen() - parse the output of child???

## NOTES FOR ARMv7
Do not compile with makefile, the os will append compile options that does not work.
use:
clang runner-wasmtime.c -I wasmtime/include/ -L wasmtime/lib/ wasmtime/lib/libwasmtime.so -ldl -lpthread -lm -o runner-wasmtime
for example