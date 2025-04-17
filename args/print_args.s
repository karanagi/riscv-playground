.global _start

.equ SYS_WRITE,		64
.equ SYS_EXIT, 		93

.equ STDOUT_FILENO,	0

.equ EXIT_SUCESS,	0

.equ WORD_SIZE,		8

_start:
	lw		t0, (sp)			# argc
	mv		t1, sp			
	addi	t1, t1, WORD_SIZE	# argv

.loop:
	beqz	t0, exit

	mv		s0, t0
	mv		s1, t1

	ld		a0, (t1)			# load *argv
	call	print_str

	mv		t0, s0
	mv		t1, s1

	addi	t0, t0, -1
	addi	t1, t1, WORD_SIZE
	j		.loop

exit:
	li		a0, EXIT_SUCESS
	mv		a0, t2
	li		a7, SYS_EXIT
	ecall

print_str:
	mv		t0, zero		# length
	mv		t1, a0
	mv		t2, zero

.count_loop:
	lb		t3, (t1)
	beqz	t3, .print
	addi	t2, t2, 1
	addi	t1, t1, 1
	j		.count_loop
	
.print:
	mv		a2, t2
	mv		a1, a0
	li		a0, STDOUT_FILENO
	li		a7, SYS_WRITE
	ecall

	li		a2, 1
	la		a1, newline
	li		a0, STDOUT_FILENO
	li		a7, SYS_WRITE
	ecall

	ret

.section .rodata

newline:
	.ascii "\n"
