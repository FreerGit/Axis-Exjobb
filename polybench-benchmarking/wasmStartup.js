const wasi = require('wasi');
const fs = require('fs');

var wasiObj = new wasi.WASI();

var memory = new WebAssembly.Memory({ initial: 32767, maximum: 65536 });

const importObject = {
    wasi_snapshot_preview1: wasiObj.wasiImport,
    memory
};

const compileAndStart = async (path) => {
    console.log(path)

    const wasm = await WebAssembly.instantiate(fs.readFileSync(path), importObject);
    console.log('fdsfsdfdsfdsfsd')
    wasiObj.start(wasm.instance);
    console.log('fdsfsdfdsfdxxxx')
    const wasmInstance = wasm.instance;
    const wasmExports = wasmInstance.exports

    wasmExports.memory.grow(3);

    return { wasmInstance, wasmExports };
}

module.exports = { compileAndStart }

// -Wl,--initial-memory=327680 -Wl,--max-memory=6553600 -z stack-size=196608
// CC="./wasi-sdk-12.0/bin/clang --sysroot=./wasi-sdk-12.0/share/wasi-sysroot -Wl,--initial-memory=327680 -Wl,--max-memory=6553600 -z stack-size=196608 --include-directory=polybench-src/PolyBenchC-4/utilities/ --include polybench-src/PolyBenchC-4/utilities/polybench.c -O3"