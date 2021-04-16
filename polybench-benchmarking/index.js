const { compileAndStart } = require('./wasmStartup.js')
const performance = require('performance');
const start = async () => {
    const path = process.argv[2]
    // performance.clearMarks()
    const { wasmInstance, wasmExports } = await compileAndStart(`${__dirname}/${path}`);
    console.log('fdsfdsfds')
    // console.time('test');
    startTime = performance.now();
    console.log('fdsfsd')
    // console.log(wasiObj.start(wasm.instance));
    wasmExports._start();
    endTime = performance.now()
    // performance.mark('end')
    console.log(`${endTime - startTime}`)
    // console.timeEnd('test');
}


start();