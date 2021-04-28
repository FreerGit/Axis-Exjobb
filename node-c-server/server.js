const http = require("http");
// const wasi = require('wasi');
const { compileAndStart } = require('./wasmStartup.js')
const { jsAndWasmQuickSort } = require('./benchmarks/quicksort.js')

const host = 'localhost';
const port = 8000;

// var wasiObj = new wasi.WASI();

// var memory = new WebAssembly.Memory({ initial: 65536, maximum: 65536 });

// const importObject = {
//     wasi_snapshot_preview1: wasiObj.wasiImport,
//     memory
// };


const runWasmBenchmarks = async () => {
    const { wasmInstance, wasmExports } = await compileAndStart(__dirname + "/calc.wasm");

    await jsAndWasmQuickSort(wasmExports)

};

runWasmBenchmarks()

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