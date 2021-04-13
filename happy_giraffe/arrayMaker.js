
const createWA = (inArray, memBuf, type = "i", offset = 0) => {
    let wArray;
    switch (type) {
        case "i":
            wArray = new Int32Array(memBuf, offset, inArray.length);
            break;
        case "ui":
            wArray = new Uint32Array(memBuf, offset, inArray.length);
            break;
        case "mi":
            wArray = new Int8Array(memBuf, offset, inArray.length);
            break;
        case "mui":
            wArray = new Uint8Array(memBuf, offset, inArray.length);
            break;
        case "si":
            wArray = new Int16Array(memBuf, offset, inArray.length);
            break;
        case "sui":
            wArray = new Uint16Array(memBuf, offset, inArray.length);
            break;
        case "bi":
            wArray = new BigInt64Array(memBuf, offset, inArray.length);
            break;
        case "bui":
            wArray = new BigUint64Array(memBuf, offset, inArray.length);
            break;
        case "f":
            wArray = new Float32Array(memBuf, offset, inArray.length);
            break;
        case "bf":
            wArray = new Float64Array(memBuf, offset, inArray.length);
            break;
        default:
            return new Int32Array([0], 0, 1);

    }

    wArray.set(inArray);

    return wArray;
}

module.exports = { createWA };