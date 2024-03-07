OUT = $(LIB) $(LIB).$(MAJ) $(LIB).$(MAJ).$(MINOR)
OBJS = grt.o $(OUT) demo

LIBNAME = grt
LIB = lib$(LIBNAME).so
MAJ = 0
MINOR = 1
all: $(LIB).$(MAJ).$(MINOR) demo

grt.o: grt.c grt.h
	gcc -c -fPIC grt.c

$(LIB).$(MAJ).$(MINOR): grt.o
	gcc -shared -o $@ -Wl,-soname,$(LIB).$(MAJ) $^
	ln -sf $(LIB).$(MAJ).$(MINOR) $(LIB).$(MAJ)
	ln -sf $(LIB).$(MAJ) $(LIB)

demo: demo.c
	LD_LIBRARY_PATH=. gcc -L. -o $@ $^ -lgrt

.PHONY: run
run:
	LD_LIBRARY_PATH=. ./demo

.PHONY: clean
clean:
	rm -f $(OBJS)

