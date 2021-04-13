const { createWA } = require('../../happy_giraffe/arrayMaker.js')
const { isSorted } = require('../../happy_giraffe/helpers.js')
const { performance } = require('perf_hooks');


function swap(items, leftIndex, rightIndex) {
    var temp = items[leftIndex];
    items[leftIndex] = items[rightIndex];
    items[rightIndex] = temp;
}
function partition(items, left, right) {
    var pivot = items[Math.floor((right + left) / 2)], //middle element
        i = left, //left pointer
        j = right; //right pointer
    while (i <= j) {
        while (items[i] < pivot) {
            i++;
        }
        while (items[j] > pivot) {
            j--;
        }
        if (i <= j) {
            swap(items, i, j); //sawpping two elements
            i++;
            j--;
        }
    }
    return i;
}

function quickSort(items, left, right) {
    var index;
    if (items.length > 1) {
        index = partition(items, left, right); //index returned from partition
        if (left < index - 1) { //more elements on the left side of the pivot
            quickSort(items, left, index - 1);
        }
        if (index < right) { //more elements on the right side of the pivot
            quickSort(items, index, right);
        }
    }
    return items;
}

const getRandomUnsortedList = (size, minRandom, maxRandom) => {
    const getRandomArbitrary = (min, max) => {
        return Math.round(Math.random() * (max - min) + min);
    }

    var unsortedList = [...Array(size).keys()].map(
        i => getRandomArbitrary(minRandom, maxRandom));
    return unsortedList;
}


const jsAndWasmQuickSort = async (wasm) => {
    const unsortedList = getRandomUnsortedList(20000, 0, 500)
    const array = createWA(unsortedList, wasm.memory.buffer, "i", 4)
    // console.log(`${wasm.memory}`)
    console.log('--------------------')
    var t0 = performance.now()
    const myNumber = wasm.testSort(array.byteOffset, array.length);
    console.log(`${array.length}`)
    // console.log(isSorted(array))
    var t1 = performance.now()
    console.log(`wasm took ${t1 - t0}`);
    console.log('--------------------')

    var t2 = performance.now()
    const xxx = quickSort(unsortedList, 0, unsortedList.length - 1)
    // console.log(isSorted(xxx))
    var t3 = performance.now()
    console.log(`js took ${t3 - t2}`)
    console.log('--------------------')

    console.log(myNumber);
};

module.exports = { jsAndWasmQuickSort }