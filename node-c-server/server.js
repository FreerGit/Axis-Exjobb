const http = require("http");
const fs = require('fs');
const { performance } = require('perf_hooks');
const wasi = require('wasi');
const { ccallArrays, cwrapArrays } = require("wasm-arrays")

const host = 'localhost';
const port = 8000;

var wasiObj = new wasi.WASI();

const importObject = {
    wasi_snapshot_preview1: wasiObj.wasiImport
};

function getRandomArbitrary(min, max) {
    return Math.round(Math.random() * (max - min) + min);
}

var unsortedList = [...Array(100).keys()].map(i => getRandomArbitrary(0, 20));

const testx = async () => {

    const wasm = await WebAssembly.instantiate(fs.readFileSync(__dirname + "/calc.wasm"), importObject);
    module.exports = wasm.exports;

    wasiObj.start(wasm.instance);

    console.log(wasm.instance.exports)

    const exp = wasm.instance.exports;
    console.log('--------------------')
    const array = new Int32Array(exp.memory.buffer, 0, 100)
    array.set(unsortedList);

    const myNumber = exp.testSort(array.byteOffset, array.length);
    console.log('--------------------')

    console.log(myNumber); // 2126
};

testx()

// const jsFactorial = (n) => {
//     if (n < 2) return 1;
//     else return n * jsFactorial(n - 1);
// }



// const requestListener = function (req, res) {
//     const url = req.url;
//     if (url == '/wasm') {
//         res.writeHead(200);
//         var t0 = performance.now()
//         const output = wasmModule.exports.factorial(20).toString()
//         // const output = exports._testSort(unsortedList, unsortedList.length).toString()
//         var t1 = performance.now()
//         res.end(`wasm took ${t1 - t0} resulting in: ${output}`);

//     }


//     else if (url == '/js') {
//         res.writeHead(200);
//         var t0 = performance.now()
//         const output = jsFactorial(100).toString()
//         var t1 = performance.now()
//         res.end(`js took ${t1 - t0} resulting in: ${output}`);
//     }
//     else {
//         res.writeHead(200);
//         res.end("welcome");
//     }
// };

// const server = http.createServer(requestListener);
// server.listen(port, host, () => {
//     console.log(`Server is running on http://${host}:${port}`);
// });