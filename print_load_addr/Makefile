TOOLCHAIN=riscv64-linux-gnu
AS=$(TOOLCHAIN)-as
LD=$(TOOLCHAIN)-ld

print_laddr: print_laddr.o
	$(LD) print_laddr.o -o print_laddr

print_laddr.o: 

run: print_laddr
	./run.sh print_laddr

debug: print_laddr
	./run.sh -d print_laddr

clean:
	rm print_laddr print_laddr.o

.PHONY:clean run debug
