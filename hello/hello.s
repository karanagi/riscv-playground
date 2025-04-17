.global _start

.equ SYS_WRITE, 64
.equ SYS_EXIT, 93

.equ STDOUT_FILENO,	0

.equ EXIT_SUCCESS,	0

.section .text
_start:
	# write syscall
	li	a0, STDOUT_FILENO
	la	a1, msg

<<<<<<< HEAD
=======
	# calculate strlen
>>>>>>> cp
	la	t0, msgend
	la	t1, msg
	sub	a2, t0, t1

	li	a7, SYS_WRITE
	ecall

	# exit syscall
	li	a0, EXIT_SUCCESS
	li	a7, SYS_EXIT
	ecall

.section .rodata
<<<<<<< HEAD
msg: 
	.ascii "Hello RISC-V!\n"
=======
msg: .ascii "Hello RISC-V!\n"
>>>>>>> cp
msgend:
