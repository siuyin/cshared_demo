OUT = $(LIB) $(LIB).$(MAJ) $(LIB).$(MAJ).$(MINOR)
OBJS = grt.o $(OUT) demo demo2

LIBNAME = grt
LIB = lib$(LIBNAME).so
MAJ = 0
MINOR = 1
all: $(LIB).$(MAJ).$(MINOR) demo demo2

grt.o: grt.c grt.h
	gcc -c -fPIC grt.c

$(LIB).$(MAJ).$(MINOR): grt.o
	gcc -shared -o $@ -Wl,-soname,$(LIB).$(MAJ) $^
	ln -sf $(LIB).$(MAJ).$(MINOR) $(LIB).$(MAJ)
	ln -sf $(LIB).$(MAJ) $(LIB)

demo: demo.c $(LIB).$(MAJ).$(MINOR)
	LD_LIBRARY_PATH=. gcc -L. -o $@ demo.c -l$(LIBNAME)

demo2: demo2.c $(LIB).$(MAJ).$(MINOR)
	LD_LIBRARY_PATH=. gcc -L. -o $@ demo2.c -l$(LIBNAME)

.PHONY: run
run: demo demo2
	LD_LIBRARY_PATH=. ./demo
	LD_LIBRARY_PATH=. ./demo2

.PHONY: clean
clean:
	rm -f $(OBJS)

