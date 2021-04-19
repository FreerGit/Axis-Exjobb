#!/bin/bash
while getopts 'ml' flag
do
    case "${flag}" in
        m) cmd="wasi-sdk-12.0-macos" ;;
        l) cmd="wasi-sdk-12.0" ;;
    esac
done

function setup {
    echo $cmd
    compile_command="./wasi-sdk-12.0-macos/bin/clang --sysroot=./wasi-sdk-12.0-macos/share/wasi-sysroot src/startup.c -o wasm-binaries/startup.wasm"
    compile_c="gcc src/startup.c -o c-binaries/startup"
    # echo $compile_command

    eval $compile_command
    eval $compile_c

    [[ ! -d wasm-binaries ]] && mkdir ./wasm-binaries || echo found wasm-binaries/;
}


setup cmd
