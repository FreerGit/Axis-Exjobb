# To compile another file
```
clang <src-file> \
-I <relative-path-to>/biserial-coati/headers \
-I <relative-path-to>/wasmtime/crates/c-api/include \
-I <relative-path-to>/wasmtime/crates/c-api/wasm-c-api/include \
<if-on-linux> -ldl -lpthread -lm \
<if-on-windows> - ws2_32.lib advapi32.lib userenv.lib ntdll.lib shell32.lib ole32.lib \
wasmtime/target/release/libwasmtime.a \
<relative-path-to>/biserial-coati/wrappers/wasmtime_wrapper.c \
-o <destination>
```

# Notes
Not intended to be run standalone
