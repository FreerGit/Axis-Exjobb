const isSorted = (sArray) => {
    sArray.forEach( (element, i, sA) => {
        if (element > sA[i+1]) {
            return false;
        }
    });
    return true;
}