# C
To run the compiled C-program, run:   
```docker build -f C.Dockerfile -t <tagname> . && docker run <tagname>```
# C -> Wasm
## The automatic way
To run the wasm-program automatically, run:   
```docker build -f Wasm.Dockerfile -t <tagname> . && docker run <tagname>```
## The manual way
Crusty-cat is an example of how the json-parsing library jansson can be compiled an ran.

The dockerfile shows how the library is compiled and ran normally, the output is then normal x86. 

To do compile jansson library can also be compiled to wasm and ran in nodejs with emscripten to do this we have made a docker container .tar file that can be ran. It is called emscripten-wasm under crusty-cat directory. 

To explain simply how this was done:
Install emscripten, to install and activate the compiler follow this guide: https://emscripten.org/docs/getting_started/downloads.html 

After that the jansson library needs to be installed: https://digip.org/jansson/ 

Then simply go to jansson directory and run:
`emcmake cmake .`
`emmake make`
`emmake make install`

Depending on the docker image used you may have to fiddle with the path, and the pkg-config
If the program cannot find the libjansson.so file then try and run: 
`export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/path/to/libjansson*`
libjansson* can be found with `find / -name libjansson*`

Hopefully that should work and the simply go to the directory /opt/vdo/jsontest2
and run: 
`emcc -lnodefs.js parse.c -ljansson -L/opt/vdo/jsontest/jansson-2.13.1/emcc-lib/lib/ -I/opt/vdo/jsontest/jansson-2.13.1/bin -o parse.js` 

`-lnodefs.js` is to enable the filesystem so that the program can find the commits.json file
`-l` and `-L` and for include and include-dir respectivly, simply point to the jansson library.

lastly tell the compiler that it should output the js code glue with the wasm with -o output-file-name.js

and run with `node parse.js`!!
