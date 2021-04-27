#!/bin/bash
while getopts 'ml' flag
do
    case "${flag}" in
        m) cmd="wasi-sdk-12.0-macos" ;;
        l) cmd="wasi-sdk-12.0-linux" ;;
    esac
done

function setup {
    # Copy over correct wasi-sdk
    cp -r ../wasi-sdks/$cmd .;

    #create folders if they don't exist
    [[ ! -d wasm-binaries ]] && mkdir ./wasm-binaries || echo found wasm-binaries/;
    [[ ! -d c-binaries ]] && mkdir ./c-binaries || echo found c-binaries/;

    ./$cmd/bin/clang --sysroot=./$cmd/share/wasi-sysroot src/startup.c -o wasm-binaries/startup.wasm
    gcc src/startup.c -o c-binaries/startup

    rm -rf ./$cmd
}

setup cmd
