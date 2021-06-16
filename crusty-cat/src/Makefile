PROG1	= jsondecoder
OBJS1	= $(PROG1).c
PROGS	= $(PROG1)

PKGS = jansson

CFLAGS += $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --cflags $(PKGS))
LDLIBS += $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --libs $(PKGS))

# CFLAGS += -L/opt/vdo/jansson/build/host/src/.libs

EMCC = emcc -O3
# CFLAGS += -I/Users/sebastig/Downloads/wasm-marching-squares-master/include/jansson-2.13.1/emcc-lib/include
# LDFLAGS += /Users/sebastig/Downloads/wasm-marching-squares-master/include/jansson-2.13.1/emcc-lib/lib/libjansson.a
$(PROG1): $(OBJS1)
	clang $(CFLAGS) $(LDFLAGS) $^ $(LIBS) $(LDLIBS) -o $@.out

clean:
	rm -f $(PROGS) *.o *.eap *.wasm
