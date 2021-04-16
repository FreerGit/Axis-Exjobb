#!/bin/bash
compile_command="CC=\"./wasi-sdk-12.0/bin/clang --sysroot=./wasi-sdk-12.0/share/wasi-sysroot --include-directory=polybench-src/PolyBenchC-4/utilities/ --include polybench-src/PolyBenchC-4/utilities/polybench.c -O3 -DPOLYBENCH_TIME\""
benchmark_path="./polybench-src/PolyBenchC-4/utilities/benchmark_list"

root_to_poly_root="./polybench-src/PolyBenchC-4/"

# echo $compile_command
eval $compile_command

while IFS= read -r line
do
    #Change echo to actual run command later
    cmd='$CC $root_to_poly_root${line:2} -o ./wasm-binaries/$(basename $line .c).wasm'
    eval $cmd
done < "$benchmark_path"

