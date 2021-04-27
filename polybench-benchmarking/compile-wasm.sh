#!/bin/bash
while getopts 'ml' flag
do
    case "${flag}" in
        m) arch="wasi-sdk-12.0-macos" ;;
        l) arch="wasi-sdk-12.0-linux" ;;
    esac
done

function setup {
    # Copy over correct wasi-sdk
    cp -r ../wasi-sdks/$arch .;

    [[ ! -d c-binaries ]] && mkdir ./c-binaries || echo found c-binaries/;
    [[ ! -d wasm-binaries ]] && mkdir ./wasm-binaries || echo found wasm-binaries/;

    compile_command="CC=\"./${arch}/bin/clang --sysroot=./${arch}/share/wasi-sysroot --include-directory=polybench-src/PolyBenchC-4/utilities/ --include polybench-src/PolyBenchC-4/utilities/polybench.c -O3 -lm\""
    benchmark_path="./polybench-src/PolyBenchC-4/utilities/benchmark_list"

    root_to_poly_root="./polybench-src/PolyBenchC-4/"

    # echo $compile_command
    eval $compile_command
}


# 1. Create ProgressBar function
# 1.1 Input is currentState($1) and totalState($2)
function ProgressBar {
    # Process data
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
    # Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

    # 1.2 Build progressbar strings and print the ProgressBar line
    # 1.2.1 Output example:
    # 1.2.1.1 Progress : [########################################] 100%
    printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"

}

function main {
    _end=30
    _cntr=0
    while IFS= read -r line
    do
        name=$(basename $line .c)
        #Change echo to actual run command later
        cmd='$CC $root_to_poly_root${line:2} -o ./wasm-binaries/${name}.wasm'
        eval $cmd
        cmd='clang -O3 -lm --include-directory=polybench-src/PolyBenchC-4/utilities/ --include polybench-src/PolyBenchC-4/utilities/polybench.c $root_to_poly_root${line:2} -o c-binaries/${name}'
        eval $cmd
        ((_cntr=_cntr+1))
        ProgressBar ${_cntr} ${_end}
    done < "$benchmark_path"

    rm -rf ./$arch
}

setup arch
main arch