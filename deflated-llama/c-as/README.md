# About
This is a test to implement Wasm in C.

# Building
## Wasmtime
Imported Wasm-modules need to be relative to where you are building:
`$PWD`; not from where the c-file is. This is for `fopen`.

The setup is as if you have wasmtime as a submodule of the current repo. If not, add it with ` git submodule add <link-to-wasmtime>`,
or clone it to a separate directory, can't build if source is downloaded since WasmTime relies on submodules.
### Setup
* ` git submodule update --init --recursive `
* ` cd wasmtime `
* ` cargo build --release -p wasmtime-c-api `
* ` cd .. `

### Building
```
clang <input-path> \
-I <path-to-wasmtime>/crates/c-api/include \
-I <path-to-wasmtime>/crates/c-api/wasm-c-api/include \
<path-to-wasmtime>/target/release/libwasmtime.a \
-o <output-path>
```

## Wasmer
Imported Wasm-modules can be relative to c-file.
### Setup
* Download Wasmer.

### Building
Copy the exameple Makefile and change as needed.

Build with `clang <input-file> -o <output-file>`.