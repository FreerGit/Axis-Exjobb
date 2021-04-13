CC="./wasi-sdk-12.0/bin/clang --sysroot=./wasi-sdk-12.0/share/wasi-sysroot -Wl,--export-all -Wl,--no-entry, -Wl,--initial-memory=327680 -Wl,--max-memory=6553600 -z stack-size=196608"

$CC calc.c -o calc.wasm

node --experimental-wasi-unstable-preview1 server.js

-Wl,--initial-memory=327680 <- för memory, öka detta vid runtime genom instance.memory.grow(x)

-z stack-size=196608" <- För att höja __heap_base

__heap_base är linjärt minne som (vad jag vet) inte går att ändra run-time?

Noterbart: --stack-size < --initial-memory < --max-memory

CC="./wasi-sdk-12.0/bin/clang --sysroot=./wasi-sdk-12.0/share/wasi-sysroot -Wl,--export-all -Wl,--no-entry, -Wl,--initial-memory=262144 -Wl,--max-memory=6553600 -z stack-size=196608"  <- fulla commandot

Vid compiletime produceras detta:
(memory $memory 4 100) <- 4an står för antal pages, ie --initial-memory=262144 (page_size*4)
(global $g0 (mut i32) (i32.const 197632)) <- från stack size
(global $__dso_handle i32 (i32.const 1024))
(global $__data_end i32 (i32.const 1024))
(global $__global_base i32 (i32.const 1024))
(global $__heap_base i32 (i32.const 197632)) <- från stack size
(global $__memory_base i32 (i32.const 0))
(global $__table_base i32 (i32.const 1))