const http = require("http");
const fs = require('fs');
const source = fs.readFileSync('./calc.wasm');
const { performance } = require('perf_hooks');

const host = 'localhost';
const port = 8000;

var typedArray = new Uint8Array(source);

const env = {
    memoryBase: 0,
    tableBase: 0,
    memory: new WebAssembly.Memory({
        initial: 256
    }),
    table: new WebAssembly.Table({
        initial: 0,
        element: 'anyfunc'
    })
}


WebAssembly.instantiate(typedArray, {
    env: env
}).then(result => {
    // console.log(util.inspect(result, true, 0));
    exports = result.instance.exports
}).catch(e => {
    // error caught
    console.log(e);
});

const jsFactorial = (n) => {
    if (n < 2) return 1;
    else return n * jsFactorial(n - 1);
}

const requestListener = function (req, res) {
    const url = req.url;
    if (url == '/wasm') {
        res.writeHead(200);
        var t0 = performance.now()
        const output = exports.factorial(30).toString()
        var t1 = performance.now()
        res.end(`wasm took ${t1 - t0}`);

    }

    else if (url == '/js') {
        res.writeHead(200);
        var t0 = performance.now()
        const output = exports.factorial(30).toString()
        var t1 = performance.now()
        res.end(`wasm took ${t1 - t0}`);
    }
    else {
        res.writeHead(200);
        res.end("welcome");
    }
};

const server = http.createServer(requestListener);
server.listen(port, host, () => {
    console.log(`Server is running on http://${host}:${port}`);
});