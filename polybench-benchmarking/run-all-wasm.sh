while getopts 'mtja' flag
do
    case "${flag}" in
        m) cmd="wasmer run" ;;
        t) cmd="wasmtime run" ;;
        j) cmd="node --experimental-wasi-unstable-preview1 index.js " ;;
        a) cmd="run-all"
    esac
done

main () {
    #note: dont count time if compiling.
    if [ -z "$(ls -A ./wasm-binaries/)" ] or [ -z "$(ls -A ./c-binaries)" ]; then
        echo "Compiling!!!";
        eval "./compile-wasm.sh"
    fi
    if [ -z "$(ls -A ./results/)" ]; then
        mkdir results/c; mkdir results/node; 
        mkdir results/wasmer; mkdir results/wasmtime;
        for benchmark in $(ls -d -A ./wasm-binaries/*)
        do
            filename=$(basename $benchmark .wasm)
            touch "./results/wasmer/${filename}.txt"
            touch "./results/wasmtime/${filename}.txt"
            touch "./results/node/${filename}.txt"
            touch "./results/c/${filename}.txt"
        done;
    fi
    separator="---------------------------------"

    for benchmark in $(ls -d -A ./wasm-binaries/*)
    do
        if [ "$cmd" = "run-all" ]; then
            echo $separator
            filename=$(basename $benchmark .wasm)
            echo "running benchmark for ${filename}"
            wasmer=$(eval "wasmer run ${benchmark}");
            wasmtime=$(eval "wasmtime run ${benchmark}");
            node=$(eval "node --experimental-wasi-unstable-preview1 --no-warnings index.js ${benchmark}");
            c=$(eval "./c-binaries/${filename}")
            # echo "${wasmer}" >> ./results/wasmer/${filename}.txt
            # echo "${wasmtime}" >> ./results/wasmtime/${filename}.txt
            echo "${node}" >> ./results/node/${filename}.txt
            # echo "${c}" >> ./results/c/${filename}.txt
            echo $seperator 

        else
            echo $separator
            echo $benchmark
            filename=$(basename $benchmark .wasm)
            echo "running benchmark for ${filename}"
            output=$(eval "${cmd} ${benchmark}");
            echo "${output}" >> ./results/${filename}.txt
            echo $seperator 
        fi
    done;
}

main cmd
