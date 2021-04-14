const assert = require("assert");
const myModule = require("..");
assert.equal(myModule.add(1, 2), 3);
console.log("ok");

const doConcatString = (x, y) => {
    const xPtr = myModule.__newString(x);
    const yPtr = myModule.__newString(y);
    const concat = myModule.concatString(xPtr, yPtr)
    const product = myModule.__getString(concat);
    return product;
}

console.log(doConcatString("hello", " World"))