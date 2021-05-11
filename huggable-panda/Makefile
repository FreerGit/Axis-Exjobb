CFLAGS = --target=wasm32
LDFLAGS = -Wl,--export-all -Wl,--no-entry

.SILENT: fibb fibb.o
build_fibb: fibb.o

OBJS  = $(SRCS:.c=.o)
all: $(PROGS)
$(PROGS): $(OBJS)
    $(CC) $^ -o $@
clean:
    rm -f $(PROGS) *.o

compile: clean build_fibb cleanup

.PHONY: clean
.SILENT: clean
clean:
	rm -f fibb.o fibb

.PHONY: cleanup
.SILENT: cleanup
cleanup:
	rm -f fibb.o