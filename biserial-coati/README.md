# To compile another file
clang <src-file> \
-I <relative-path-to>/biserial-coati/headers \
-I <relative-path-to>/wasmtime/crates/c-api/include \
-I <relative-path-to>/wasmtime/crates/c-api/wasm-c-api/include \
wasmtime/target/release/libwasmtime.a \
<relative-path-to>/biserial-coati/wrappers/wasmtime_wrapper.c \
<<<<<<< HEAD
-o <destination>
=======
-o <destination>
>>>>>>> 85386a0 (chore: updated readme)
