.global _start

.equ SYS_WRITE,		64
.equ SYS_EXIT, 		93

.equ WORD_SIZE,		8

_start:
	lw		t0, (sp)			# argc
	mv		t1, sp			
	addi	t1, t1, WORD_SIZE	# argv

	mv		t2, zero

loop:
	beqz	t0, exit

	addi	t2, t2, 1
	addi	t0, t0, -1
	j		loop

exit:
	#li		a0, EXIT_SUCESS
	mv		a0, t2
	li		a7, SYS_EXIT
	ecall
