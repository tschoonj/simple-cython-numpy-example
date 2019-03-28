CFLAGS = -fPIC
CPPFLAGS = -I`python -c "import distutils.sysconfig;print(distutils.sysconfig.get_python_inc())"` -I`python -c "import numpy;print(numpy.get_include())"`

multiply.so: multiply_wrap.o multiply.h multiply.o
	gcc -o $@ -shared -fPIC -Wl,-soname -Wl,$@ multiply_wrap.o multiply.o

multiply_wrap.c: multiply.pyx multiply.h
	cython -I. -o multiply_wrap.c multiply.pyx



%.o : %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

.PHONY: clean test
clean:
	rm -f *.o multiply.so multiply_wrap.c

test:
	python test.py

