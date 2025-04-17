TOOLCHAIN=riscv64-linux-gnu
AS=$(TOOLCHAIN)-as
LD=$(TOOLCHAIN)-ld

cp: cp.o
	$(LD) cp.o -o cp

cp.o: 

clean:
	rm cp cp.o test*
