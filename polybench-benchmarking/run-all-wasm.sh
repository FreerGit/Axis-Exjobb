while getopts 'mtj' flag
do
    case "${flag}" in
        m) cmd="wasmer run" ;;
        t) cmd="wasmtime run" ;;
        j)  cmd="node --experimental-wasi-unstable-preview1 index.js " ;;
    esac
done

main () {
    if [ -z "$(ls -A ./wasm-binaries/)" ]; then
        echo "Compiling!!!";
        eval "./compile-wasm.sh"
    fi
    separator="---------------------------------"

    for benchmark in $(ls -d -A ./wasm-binaries/*)
    do
        echo $separator
        echo "running benchmark for ${benchmark:2}"
        eval "${cmd} ${benchmark}";
        echo $seperator 
    done;
}

time main cmd