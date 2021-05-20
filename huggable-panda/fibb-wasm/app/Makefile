PROGS = main
SRCS  = main.c
OBJS  = $(SRCS:.c=.o)
CC1 = -Iwasmtime/include -Lwasmtime/lib wasmtime/lib/libwasmtime.a -ldl -lpthread -lm 
CC2 = -Iwasmer/include -Lwasmer/lib wasmer/lib/libwasmer.a -ldl -lpthread -lm 
all:
# $(CC) -c runner-wasmtime.c 
	$(CC) runner-wasmtime.c $(CC1) -o runner-wasmtime
# $(CC) -c main-wasmtime.c
	$(CC) main-wasmtime.c $(CC1) -o main_wasmtime
# $(CC) -c runner-wasmer.c
# $(CC) runner-wasmer.c $(CC2) -o runner-wasmer
# $(CC) -c main-wasmer.c
# $(CC) main-wasmer.c $(CC2) -o main_wasmer

clean:
	rm -f $(PROGS) *.o