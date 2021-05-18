# prerequisites
* install Wasmer on python with: 
  * `pip install wasmer wasmer_compiler_cranelift`
* install WasmTime on python with:
  * `pip install wasmtime`
* install rustup
* add wasm32-wasi as target:
  * `cargo target add wasm32-wasi`
# To compile
The python-files doesn't need to be compiled.
The Rust-file is compiled by:

1. `cd sieve`
2. `cargo build --target wasm32-wasi`
    * adding `--release` will build an optimized version.
3. `cp target/wasm32-wasi/debug/sieve.wasm ../`
4. `cd ..`

# Running
To run the program, simply execute
`python3 main.py <upper limit to look for primes in>`
in tender-armadillo/.

# Notes
Additional compilers and engines can be used for Wasmer, look at https://github.com/wasmerio/wasmer-python for more info.