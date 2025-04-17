TOOLCHAIN=riscv64-linux-gnu
AS=$(TOOLCHAIN)-as
LD=$(TOOLCHAIN)-ld

hello: hello.o
	$(LD) hello.o -o hello

hello.o: 

run: hello
	qemu-riscv64 hello

clean:
	rm hello hello.o

.PHONY: clean
