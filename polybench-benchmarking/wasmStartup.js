const wasi = require('wasi');
const fs = require('fs');
const {
    performance
} = require('perf_hooks');

var wasiObj = new wasi.WASI({
    // returnOnExit: true
});
// console.log(wasiObj)

var memory = new WebAssembly.Memory({ initial: 10, maximum: 100 });

const importObject = {
    wasi_snapshot_preview1: wasiObj.wasiImport,
    // js: { mem: memory }
};


const compileAndStart = async (path) => {
    const wasm = await WebAssembly.instantiate(fs.readFileSync(path), importObject);

    start = performance.now();
    wasiObj.start(wasm.instance);
    end = performance.now();

    console.log(`${end - start}`)

    const wasmInstance = wasm.instance;
    const wasmExports = wasmInstance.exports

    return { wasmExports };
}


module.exports = { compileAndStart }