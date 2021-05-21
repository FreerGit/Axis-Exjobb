PROG1	= vdoencodeclient
OBJS1	= $(PROG1).c
PROGS	= $(PROG1)

PKGS = gio-2.0 vdostream gio-unix-2.0
WTFLAGS = -Iwasmtime/include -Lwasmtime/lib wasmtime/lib/libwasmtime.a -ldl -lpthread -lm
CFLAGS += $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --cflags $(PKGS))
LDLIBS += $(shell PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config --libs $(PKGS))

CFLAGS += -Wall
CLANG = clang --sysroot=/opt/axis/acapsdk/sysroots/aarch64
CFLAGS += -L/lib/ -L/lib/aarch64-linux-gnu/lib
CFLAGS += -I/lib/aarch64-linux-gnu/include
CFLAGS +=


all: $(PROG1)
# @ echo $(CC)
# @ echo $(LDLIBS)
# $(CC) runner-wasmtime.c $(WTIMEFLAGS) -o runner-wasmtime
# $(CC) main-wasmtime.c $(WTIMEFLAGS) -o main_wasmtime
# $(CC) $(CFLAGS) $(LDFLAGS) vdoencodeclient.c $(LIBS) $(LDLIBS) -o vdo.wasm

$(PROG1): $(OBJS1)
	$(CLANG) -target wasm32 $(CFLAGS) $(LDFLAGS) $^ $(LIBS) $(LDLIBS) -o $@.wasm

clean:
	rm -f $(PROGS) *.o *.eap