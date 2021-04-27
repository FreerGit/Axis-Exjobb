# Coompile to arm
Assuming aarch64 with 64-bit os:
* download clang, llvm, and lld.
* download and unzip libclang_rt.builtins-wasm32-wasi-12.0.tar.gz and unzip
* move the wasi subfolder to /usr/lib/clang/<version>/lib
* compile with "clang --target=wasm32-wasi --sysroot=<path-to-wasisdk-sysroot> <file> -o <output>"

