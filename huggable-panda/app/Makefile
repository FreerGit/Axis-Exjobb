PROGS = main
SRCS  = main.c
OBJS  = $(SRCS:.c=.o)
CC = clang -Iwasmtime/include -Lwasmtime/lib wasmtime/lib/libwasmtime.so
all:
	$(CC) runner.c -o runner
	$(CC) main.c -o main
clean:
	rm -f $(PROGS) *.o