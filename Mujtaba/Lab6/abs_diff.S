.global _start

.section .data
int1: .word 5
int2: .word 12

.section .text
_start:
	la t0, int1 # Load the address of int1
	la t1, int2 # Load the address of int2
	lw t2, (t0) # Load the value at address t0
	lw t3, (t1) # Load the value at address t1
	blt t3, t2, greater_than # if t3 > t2 then jump to greater_than
	sub t4, t3, t2 # else do this
	j done # jump to done

greater_than:
	sub t4, t2, t3 # if branch

done:
	# Spike signal to quit
	li t0, 1
	la t1, tohost
	sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
