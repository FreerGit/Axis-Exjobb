const { compileAndStart } = require('./wasmStartup.js')

const start = async () => {
    const path = process.argv[2]

    const { wasmExports } = await compileAndStart(`${__dirname}/${path}`);

}


start();