const myModule = require("..");

const newString = (str) => {
    return myModule.__newString(str);
}

const getString = (x) => {
    return myModule.__getString(x);
}

module.exports = { newString, getString };