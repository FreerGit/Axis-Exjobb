# How to compile
You should not need to compile manually, run-all.py will do it for you, however if you'd like to compile manually simply run ```bash bash compile-all.sh -m OR -l``` m stands for macos and l stands for linux

# Notes for compililation to arm
Assuming aarch64 with 64-bit os:
* download clang, llvm, and lld.
* download and unzip libclang_rt.builtins-wasm32-wasi-12.0.tar.gz and unzip, can be found at https://github.com/WebAssembly/wasi-sdk/releases/tag/wasi-sdk-12
* move the wasi subfolder to /usr/lib/clang/{version}/lib
* compile with "clang --target=wasm32-wasi --sysroot=path-to-wasisdk-sysroot [c-file] -o [output-file]"

# Cross compile to arm (aarch64)
path-to-clang-optionally-use-wasi-sdk --sysroot=path-to-wasisdk-sysroot c-file -arch aarch64linux -o output

# How to run
Simply run ```bash python3 run-all.py m OR l``` m stands for macos and l stands for linux. If you are on OSX, the docker part of the startup will not work since the C-file will be compiled for macos. Cross compilation could be done, or simply change the docker image.