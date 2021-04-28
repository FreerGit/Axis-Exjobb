const assert = require("assert");
const myModule = require("..");
assert.strictEqual(myModule.add(1, 2), 3);


const doFibb = (n) => {
    // let cache = new Map();
    result = myModule.fib(n);
    return result;
}
assert.strictEqual(doFibb(BigInt(50)), BigInt(12586269025));
console.log('Test ran successfully')