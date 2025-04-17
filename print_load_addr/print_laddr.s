.global _start

.include "../include/syscall_defs.inc"
.include "../include/stdlib.inc"

.equ STACKSIZE,		0x8
.equ PAGESIZE,		0x1000
.equ WORDSIZE, 		0x8

_start:
	addi sp, sp, -STACKSIZE
	sd ra, (sp)

	call get_load_address
	call print_hex
	addi sp, sp, STACKSIZE

	li a0, EXIT_SUCCESS
	li a7, SYS_EXIT
	ecall

get_load_address:
	auipc t0, 0x0

	# align the current pc to the page size
	li t4, PAGESIZE
	addi t4, t4, -1
	not t4, t4
	and t0, t0, t4

.loop:
	mv t3, zero

	lb t1, (t0)
	xor t2, t1, 0x7f
	or t3, t3, t2

	lb t1, 1(t0)
	xor t2, t1, 0x45
	or t3, t3, t2

	lb t1, 2(t0)
	xor t2, t1, 0x4c
	or t3, t3, t2

	lb t1, 3(t0)
	xor t2, t1, 0x46
	or t3, t3, t2

	beqz t3, .found

	li t4, PAGESIZE
	sub t0, t0, t4
	j .loop

.found:
	mv a0, t0
	ret

print_hex:
	addi sp, sp, -19

	addi t0, sp, 16
	li t5, 4			# char count, initialized with the count of "0x" and "\n\x00"

	# store "\n\x00" at the end of the buffer
	sb zero, 2(t0)
	li t1, 0xa
	sb t1, 1(t0)

.hex_loop:
	andi t2, a0, 0xf
	srli a0, a0, 4

	li t3, 0x30
	li t4, 10

	blt t2, t4, .convert
	li t3, 0x61
	addi t2, t2, -10

.convert:
	add t2, t2, t3
	sb t2, (t0)
	addi t0, t0, -1
	beqz a0, .print

	addi t5, t5, 1
	j .hex_loop

.print:
	# store "0x" in the front
	li t2, 0x78
	sb t2, (t0)
	addi t0, t0, -1

	li t2, 0x30
	sb t2, (t0)

	mv a2, t5
	mv a1, t0
	li a0, STDOUT_FILENO
	li a7, SYS_WRITE
	ecall
	
	addi sp, sp, 19
	ret
