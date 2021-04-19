while getopts 'mtalx' flag
do
    case "${flag}" in
        m) cmd="wasmer run --llvm" ;;
        s) cmd="wasmer run" ;;
        t) cmd="wasmtime run" ;;
        # j) cmd="node --experimental-wasi-unstable-preview1 index.js " ;;
        a) cmd="run-all" ;;
        x) ostype="m" ;;
        l) ostype="l" ;;
    esac
done

main () {
    #note: dont count time if compiling.
    if [ -z "$(ls -A ./wasm-binaries/)" ] || [ -z "$(ls -A ./c-binaries)" ]; then
        echo "Compiling!!!";
        eval "./compile-wasm.sh -${ostype}"
    fi
    if [ -z "$(ls -A ./results/time)" ]; then
        mkdir results/time
        mkdir results/memory
        mkdir results/time/c && mkdir results/memory/c; 
        mkdir results/time/wasmerllvm && mkdir results/memory/wasmerllvm; 
        mkdir results/time/wasmerslow && mkdir results/memory/wasmerslow; 
        mkdir results/time/wasmtime && mkdir results/memory/wasmtime; 
        for benchmark in $(ls -d -A ./wasm-binaries/*)
        do
            filename=$(basename $benchmark .wasm)
            touch "./results/time/c/${filename}.txt"
            touch "./results/memory/c/${filename}.txt"

            touch "./results/time/wasmerllvm/${filename}.txt"
            touch ".results/memory/wasmerllvm/${filename}.txt"

            touch "./results/time/wasmerslow/${filename}.txt"
            touch "./results/memory/wasmerslow/${filename}.txt"

            touch "./results/time/wasmtime/${filename}.txt"
            touch "./results/memory/wasmtime/${filename}.txt"
        done;
    fi
    separator="---------------------------------"

    for benchmark in $(ls -d -A ./wasm-binaries/*)
    do
        if [ "$cmd" = "run-all" ]; then
            echo $separator
            filename=$(basename $benchmark .wasm)
            gtime="gtime -f '%M' -o results/memory/"
            echo "running benchmark for ${filename}"
            wasmerslow=$(eval "${gtime}wasmerslow/${filename}.txt wasmer run ${benchmark}");
            wasmerllvm=$(eval "${gtime}wasmerllvm/${filename}.txt wasmer run --llvm ${benchmark}")
            wasmtime=$(eval "${gtime}wasmtime/${filename}.txt wasmtime run ${benchmark}");
            # node=$(eval "node --experimental-wasi-unstable-preview1 --no-warnings index.js ${benchmark}");
            c=$(eval "${gtime}c/${filename}.txt ./c-binaries/${filename}")

            echo "${wasmerslow}" >> ./results/time/wasmerslow/${filename}.txt
            echo "${wasmerllvm}" >> ./results/time/wasmerllvm/${filename}.txt
            echo "${wasmtime}" >> ./results/time/wasmtime/${filename}.txt
            #echo "${node}" >> ./results/node/${filename}.txt
            echo "${c}" >> ./results/time/c/${filename}.txt
            echo $seperator 

        else
            echo $separator
            echo $benchmark
            filename=$(basename $benchmark .wasm)
            echo "running benchmark for ${filename}"
            output=$(eval "/usr/bin/time -l ${cmd} ${benchmark}");
            echo "${output}" >> ./results/${filename}.txt
            echo $seperator 
        fi
    done;
}

main cmd ostype
