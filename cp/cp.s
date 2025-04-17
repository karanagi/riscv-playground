.global _start

.equ SYS_OPENAT, 	56
.equ SYS_READ, 		63
.equ SYS_WRITE, 	64
.equ SYS_EXIT, 		93

.equ STDERR_FILENO,	2

.equ EXIT_SUCCESS,	0
.equ EXIT_FAILURE,	1

_start:
	ld 		t0, (sp)

	la		a0, usage
	call	strlen

	#li		a0, EXIT_SUCCESS
	li		a7, SYS_EXIT	
	ecall

# err_exit
#	a0: exit status
#	a1: error message
err_exit:
	mv s0, a1

	mv a1, a0
	li a0, STDERR_FILENO

# strlen(s)
#	a0: string
#	return value: string length
strlen:
	mv 		t1, zero

.strlen_loop:
	lb 		t0, (a0)
	beqz 	t0, .strlen_exit
	addi	t1, t1, 1
	addi	a0, a0, 1
	j 		.strlen_loop

.strlen_exit:
	mv		a0, t1
	ret

.section .rodata
usage: .ascii "usage: ./cp src-file dst-file\n\x00"
