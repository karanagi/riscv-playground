# RISC-V Assembly Playground

Some programs written in RISC-V 64 assembly.

These programs can be built using the RISC-V gnu tool chain, and run using qemu's riscv user space emulator.

Example: Running `hello/hello.s` on Arch linux:

```console
$ riscv64-linux-gnu-as hello.s -o hello.o
$ riscv64-linux-gnu-ld hello.o -o hello
$ qemu-riscv64 hello
Hello RISC-V!
```

## Program Listing
- `hello`: hello world.
- `args/count_args.s`: count the number of command line arguments (which is kind of useless since one could simply look at `argc`).
- `args/print_args.s`: prints all of the command line arguments.
- `cp/cp.s`: a simple and crude implementation of `cp`.
- `print_load_addr/print_load_addr.s`: prints the load address.

## Links and Resources
- <https://asm-docs.microagi.org/risc-v/riscv-asm.html>
- <https://jborza.com/post/2021-05-11-riscv-linux-syscalls/>
- <https://github.com/scotws/RISC-V-tests/blob/master/docs/riscv_howto_syscalls.md>
- <https://projectf.io/posts/riscv-cheat-sheet/>
