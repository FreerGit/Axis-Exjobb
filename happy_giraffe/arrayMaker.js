const createWA = (inArray, memBuf) => {
    let wArray;
    if (inArray[0] % 1 == 0) {
        wArray = new Int32Array(memBuf, 0, inArray.length);
    } else {
        wArray = new Float32Array(memBuf, 0, inArray.length);
    }

    wArray.set(inArray);

    return wArray;
}

module.exports = createWA