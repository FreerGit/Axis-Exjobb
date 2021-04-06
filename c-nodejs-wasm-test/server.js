const fs = require('fs');
var source = fs.readFileSync('./test.wasm');

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
    const exports = result.instance.exports
    console.log(exports.add(10, 9));
    console.log(exports.mul(5, 5))
    console.log(exports.factorial(10))
}).catch(e => {
    // error caught
    console.log(e);
});
