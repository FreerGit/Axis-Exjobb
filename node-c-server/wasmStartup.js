const wasi = require('wasi');
const fs = require('fs');

var wasiObj = new wasi.WASI();

var memory = new WebAssembly.Memory({ initial: 65536, maximum: 65536 });

const importObject = {
    wasi_snapshot_preview1: wasiObj.wasiImport,
    memory
};


const compileAndStart = async (path) => {
    const wasm = await WebAssembly.instantiate(fs.readFileSync(path), importObject);
    wasiObj.start(wasm.instance);
    const wasmInstance = wasm.instance;
    const wasmExports = wasmInstance.exports

    return { wasmInstance, wasmExports };
}


module.exports = { compileAndStart }