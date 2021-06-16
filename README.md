# Axis-Exjobb

## Important notes
* Some projects may require downloads of sdks and or executables, before reading and or running code in any projects, look at its respective README for information. For example, some project requires the download of certain c-apis to run.
---
## Repository Overview
Check each individual file for a more information about each directory
### Biserial Coati
__Contains__:
* Wrappers for WasmTime to ease the development process.
---
### Deflated LLama
__Contains__:
* __C-AS__
  * Examples of using Wasmer and WasmTime in C. For WasmTime, wrappers from *Biserial Coati* is used.

* __AssemblyScript__
  * Implementation of memoized Fibbonacci in AssemblyScript.
---
### Huggable panda
__Contains__:
* Example for running WasmTime inside a c-file on a **aarch64**-compatible Axis Camera
---
__Notes__:
* Major part of the Axis-part of our thesis, essentially test development to see the use cases on the cameras and the use-ability. Cross-compilation and running .eap files and such.
__
### Node AS Server
__Contains__:
* A simple Node Server with Wasm functions.
---
### Polybench Benchmarking
__Contains__:
* All relevant files for running Polybench in Wasmer/WasmTime and on Docker.

__Notes__:
* This is the biggest part of our thesis, these tests, including startup benchmarking is used to collect data for the paper.
---
### Startup Benchmarking
__Contains__:
* Files for benchmarking startup for Wasmer/WasmTime and Docker
---
### Tender Armadillo
__Contains__:
* Benchmarks comparing native Python to Wasm compiled from Rust.
---
### WASI SDKS
__Contains__:
* Highly important directory containing the sdk for wasi, both mac and linux.

__Notes__:
* This can be used to contain other api-libraries that are needed for development.
* For some projects the c-api for both wasmer and wasmtime may be required, if so, simply go to the respective github and download the release and untar it. Github repos are open source, simply google `{wasmer/wasmtime} github`.

## Basic folder structure:
```
├── biserial-coati
│   ├── headers
│   ├── wasmtime-v0.26.0-aarch64-linux-c-api
│   └── wrappers
├── crusty-cat
│   ├── as-version
│   └── src
├── deflated-llama
│   ├── assemblyscript
│   └── c-as
├── huggable-panda
│   ├── fibb-wasm
│   └── vdostream-wasm
├── node-AS-server
│   ├── assembly
│   ├── build
│   ├── lib
│   ├── node_modules
│   └── tests
├── polybench-benchmarking
│   ├── c-binaries
│   ├── polybench-src
│   ├── results
│   └── wasm-binaries
├── startup-benchmarking
│   ├── src
│   └── wasm-binaries
├── tender-armadillo
│   ├── __pycache__
│   └── sieve
└── wasi-sdks
    ├── wasi-sdk-12.0-linux
    └── wasi-sdk-12.0-macos
```