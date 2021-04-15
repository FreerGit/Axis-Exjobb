const wasi = require('wasi');
const fs = require('fs');

var wasiObj = new wasi.WASI();
console.log(wasiObj)

// var memory = new WebAssembly.Memory({ initial: 5, maximum: 10 });

const importObject = {
    wasi_snapshot_preview1: wasiObj.wasiImport,
    // js: {
    //     mem: memory
    // }
};


const compileAndStart = async (path) => {
    const wasm = await WebAssembly.instantiate(fs.readFileSync(path), importObject);
    console.log(wasm.instance.exports)
    for (var x in wasm.instance.exports.memory) {
        console.log(x)
    }
    wasiObj.start(wasm.instance);
    console.log('fdsafsd')
    const wasmInstance = wasm.instance;
    const wasmExports = wasmInstance.exports

    wasmExports.memory.grow(3);
    console.log(wasmExports)

    return { wasmInstance, wasmExports };
}


module.exports = { compileAndStart }