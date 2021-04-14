const assert = require("assert");
const myModule = require("..");
const { getString, newString } = require("../lib/helpers")


const doConcatString = (x, y) => {
    const xPtr = newString(x);
    const yPtr = newString(y);
    const concat = myModule.concatString(xPtr, yPtr)
    const product = getString(concat);
    return product;
}

const doFibb = (n) => {
    // let cache = new Map();
    result = myModule.fib(n);
    console.log(result)
}

assert.strictEqual(myModule.add(1, 2), 3);
assert.strictEqual(doConcatString("hello", " World"), "hello World")

doFibb(BigInt(1000));
console.log('OK')