const fs = require('fs');

function hex2bin(hex1) {
    return (parseInt(hex1, 16).toString(2)).padStart(8, '0');
}

var re = /[0-9A-Fa-f]{6}/g;

const hex = fs.readFileSync('./calc.wasm')
console.log(re.test(hex))
console.log(hex.length)
const bytes = hex2bin(hex)
console.log(bytes)
fs.writeFileSync('./calc1.wasm', bytes);