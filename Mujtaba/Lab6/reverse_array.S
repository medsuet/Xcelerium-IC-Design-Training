.section .data
array: .word 1, 2, 3, 4, 5
size: .word 5

.section .bss
	.align 3
_stack_top:
	.space 1024

.section .text
.global _start


_start:
	la sp, _stack_top
	la a0, array # Initial Address
	la a1, size
	lw a1, 0(a1)
	srai s0, a1, 1
	addi a1, a1, -1
	slli a2, a1, 2 # Final Address
	add a2, a2, a0
loop:
	jal swap
	addi a0, a0, 4
	addi a2, a2, -4
	beq s0, zero, done
	addi s0, s0, -1
	j loop
	

swap:
	addi sp, sp, -4
	sw ra, 0(sp)
	lw t0, 0(a0)
	lw t1, 0(a2)
	sw t0, 0(a2)
	sw t1, 0(a0)
	lwu ra, 0(sp)
	addi sp, sp, 4
	ret

done:
	# Spike signal to quit
	li t0, 1
	la t1, tohost
	sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
