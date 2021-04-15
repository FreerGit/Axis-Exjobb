const { compileAndStart } = require('./wasmStartup.js')

const start = async () => {
    const path = process.argv[2]

    console.log("hej");

    const { wasmInstance, wasmExports } = await compileAndStart(`${__dirname}/${path}`);

    // wasmExports._start();
    sleep(10);
    console.log("HEj")
}

start();