while getopts 'mtj' flag
do
    case "${flag}" in
        m) cmd="wasmer run" ;;
        t) cmd="wasmtime run" ;;
        j)  cmd="node --experimental-wasi-unstable-preview1 index.js " ;;
    esac
done

main () {
    #note: dont count time if compiling.
    if [ -z "$(ls -A ./wasm-binaries/)" ]; then
        echo "Compiling!!!";
        eval "./compile-wasm.sh"
    fi
    if [ -z "$(ls -A ./results/)" ]; then
        for benchmark in $(ls -d -A ./wasm-binaries/*)
        do
            filename=$(basename $benchmark .wasm)
            touch "./results/${filename}.txt"
        done;
    fi
    separator="---------------------------------"

    for benchmark in $(ls -d -A ./wasm-binaries/*)
    do
        echo $separator
        echo $benchmark
        filename=$(basename $benchmark .wasm)
        echo "running benchmark for ${filename}"
        output=$(eval "${cmd} ${benchmark}");
        echo "${output}" >> ./results/${filename}.txt
        echo $seperator 
    done;
}

time main cmd