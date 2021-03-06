# Axis-Exjobb

## Important notes
* Some projects may require downloads of sdks and or executables, before reading and or running code in any projects, look at its respective README for information. For example, some project requires the download of certain c-apis to run.

---
## Repository Overview
Check each individual file for a more information about each directory
### Biserial Coati π
__Contains__:
* Wrappers for WasmTime to ease the development process.
---
### Crusty Cat π
__Contains__:
* A C-version of a JSON-parser that digests github-commits and prints relevant data.
* commit.json, that contains commits from [github.com/freergit/authentication-with-haskell](https://github.com/freergit/authentication-with-haskell.git)
* Parser.c, a version of the JSON-parser with added Emscripten flags.
* A copy of the JSON-parsin library Jansson, Version 2.13.1
---
### Deflated LLamaπ¦
__Contains__:
* __C-AS__
  * Examples of using Wasmer and WasmTime in C. For WasmTime, wrappers from *Biserial Coati* is used.

* __AssemblyScript__
  * Implementation of memoized Fibbonacci in AssemblyScript.
---
### Huggable panda πΌ
__Contains__:
* Example for running WasmTime inside a c-file on a **aarch64**-compatible Axis Camera
---
__Notes__:
* Major part of the Axis-part of our thesis, essentially test development to see the use cases on the cameras and the use-ability. Cross-compilation and running .eap files and such.
__
### Node AS Server π
__Contains__:
* A simple Node Server with Wasm functions.
---
### Polybench Benchmarking π
__Contains__:
* All relevant files for running Polybench in Wasmer/WasmTime and on Docker.

__Notes__:
* This is the biggest part of our thesis, these tests, including startup benchmarking is used to collect data for the paper.
---
### Startup Benchmarking π
__Contains__:
* Files for benchmarking startup for Wasmer/WasmTime and Docker
---
### Tender Armadillo π½
__Contains__:
* Benchmarks comparing native Python to Wasm compiled from Rust.
---
### WASI SDKS πΊ
__Contains__:
* Highly important directory containing the sdk for wasi, both mac and linux.

__Notes__:
* This can be used to contain other api-libraries that are needed for development.
* For some projects the c-api for both wasmer and wasmtime may be required, if so, simply go to the respective github and download the release and untar it. Github repos are open source, simply google `{wasmer/wasmtime} github`.

## Basic folder structure:
```
βββ biserial-coati
β   βββ headers
β   βββ wasmtime-v0.26.0-aarch64-linux-c-api
β   βββ wrappers
βββ crusty-cat
β   βββ src
βββ deflated-llama
β   βββ assemblyscript
β   βββ c-as
βββ huggable-panda
β   βββ fibb-wasm
β   βββ vdostream-wasm
βββ node-AS-server
β   βββ assembly
β   βββ build
β   βββ lib
β   βββ node_modules
β   βββ tests
βββ polybench-benchmarking
β   βββ c-binaries
β   βββ polybench-src
β   βββ results
β   βββ wasm-binaries
βββ startup-benchmarking
β   βββ src
β   βββ wasm-binaries
βββ tender-armadillo
β   βββ __pycache__
β   βββ sieve
βββ wasi-sdks
    βββ wasi-sdk-12.0-linux
    βββ wasi-sdk-12.0-macos
```
