.global _start

.equ SYS_OPENAT, 	56
.equ SYS_READ, 		63
.equ SYS_WRITE, 	64
.equ SYS_EXIT, 		93

.equ AT_FDCWD,		-100

.equ STDERR_FILENO,	2

.equ EXIT_SUCCESS,	0
.equ EXIT_FAILURE,	1

.equ NARGS,			3
.equ WORD_SIZE,		8
.equ STACK_SIZE,	1024

.equ O_RDONLY,		000000
.equ O_WRONLY,		000001
.equ O_RDWR,		000002
.equ O_CREAT,		000100

.equ S_IWUSR, 		000200
.equ S_IRUSR, 		000400

_start:
	ld 		t0, (sp)
	li		t1, NARGS
	bne		t0, t1, usage

	ld		a0, WORD_SIZE*2(sp)
	ld		a1, WORD_SIZE*3(sp)
	
	call	do_copy

	li		a0, EXIT_SUCCESS
	li		a7, SYS_EXIT	
	ecall

# do_copy
#	a0: src file
#	a1: dst file
do_copy:
	addi	sp, sp, -STACK_SIZE
	mv		t1, a1
	mv		s11, x1

	# open source file
	li		a1, O_RDONLY
	call	xopen
	mv		t0, a0

	# open destination file
	li		a1, O_WRONLY
	ori		a1, a1, O_CREAT

	li		a2, S_IRUSR
	ori		a2, a2, S_IWUSR
	mv		a0, t1
	call	xopen
	mv		t1, a0

.copy_loop:
	
	li		a2, STACK_SIZE
	mv		a1, sp
	mv		a0, t0
	li		a7, SYS_READ
	ecall

	bgtz	a0, .write_data
	beqz	a0, .copy_exit
	la		a1, read_err_str
	call	err_exit

.write_data:
	mv		a2, a0
	mv		a0, t1
	li		a7, SYS_WRITE
	ecall
	bgez	a0, .copy_loop

	la		a1, write_err_str
	call	err_exit

.copy_exit:
	mv		x1, s11
	addi	sp, sp, STACK_SIZE
	ret

# xopen
#	a0: file path
#	a1: flags
#	a2: mode
xopen:
	mv		s0, a0
	mv		a3, a2
	mv		a2, a1
	mv		a1, a0
	li		a0, AT_FDCWD
	li		a7, SYS_OPENAT
	ecall

	la		a1, open_err_str
	blt		a0, zero, .xopen_err
	ret

.xopen_err:
	mv		s1, a0
	la		a0, open_fail_str
	call	eprint

	mv		a0, s0
	call	eprint

	la		a1, newline
	mv		a0, s1
	call	err_exit
	

# err_exit
#	a0: exit status
#	a1: error message
err_exit:
	mv 		s0, a0
	mv 		a0, a1
	call	strlen

	mv 		a2, a0				# length of message
	li 		a0, STDERR_FILENO
	li 		a7, SYS_WRITE
	ecall

	mv		a0, s0
	li		a7, SYS_EXIT
	ecall

eprint:
	mv		s10, ra

	mv		a1, a0
	call	strlen

	mv		ra, s10

	mv		a2, a0
	li 		a0, STDERR_FILENO
	li 		a7, SYS_WRITE
	ecall

	ret

usage:
	la		a1, usage_str
	li		a0, EXIT_FAILURE
	call	err_exit

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
usage_str: 			.ascii "usage: ./cp src-file dst-file\n\x00"
open_err_str: 		.ascii "open failed\n\x00"
read_err_str: 		.ascii "read failed\n\x00"
write_err_str: 		.ascii "write failed\n\x00"
open_fail_str: 		.ascii "failed to open: \x00"
newline: 			.ascii "\n\x00"
