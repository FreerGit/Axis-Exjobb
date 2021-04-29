# To compile another file
clang src/wasmtime/wasmtime_test.c \
-I ../../biserial-coati/headers \
-I wasmtime/crates/c-api/include \
-I wasmtime/crates/c-api/wasm-c-api/include \
wasmtime/target/release/libwasmtime.a \
../../biserial-coati/wrappers/wasmtime_wrapper.c \
-o src/wasmtime/wasmtime_test