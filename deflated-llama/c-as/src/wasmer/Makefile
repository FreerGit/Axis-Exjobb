CFLAGS = -g -I$(shell $(WASMER_DIR)/bin/wasmer config --includedir)
LDFLAGS = -Wl,-rpath,$(shell $(WASMER_DIR)/bin/wasmer config --libdir)
LDLIBS = $(shell $(WASMER_DIR)/bin/wasmer config --libs)

.SILENT: wasmer_test wasmer_test.o
wasmer_test: wasmer_test.o

all: clean wasmer_test

.PHONY: clean
.SILENT: clean
clean:
	rm -f wasmer_test.o wasmer_test