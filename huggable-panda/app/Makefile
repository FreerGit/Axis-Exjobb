PROGS = main
SRCS  = main.c
OBJS  = $(SRCS:.c=.o)
CC = clang -I wasmtime/crates/c-api/include -I wasmtime/crates/c-api/wasm-c-api/include wasmtime/target/release/libwasmtime.dylib
all: $(PROGS)
$(PROGS): $(OBJS)
	$(CC) main.c -o main
clean:
	rm -f $(PROGS) *.o