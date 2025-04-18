TOOLCHAIN=riscv64-linux-gnu
AS=$(TOOLCHAIN)-as
LD=$(TOOLCHAIN)-ld

all: count_args print_args

print_args: print_args.o
	$(LD) print_args.o -o print_args

print_args.o: 

count_args: count_args.o
	$(LD) count_args.o -o count_args

count_args.o: 

clean:
	rm print_args count_args *.o

.PHONY: clean
