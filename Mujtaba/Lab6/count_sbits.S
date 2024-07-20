.global _start

.section .data
int: .word 12

.section .text
_start:
	la t0, int     # Load the address of int
	lw t1, (t0)    # Load the value of int
	addi t2, x0, 0 # Initialize t0 with 0 for loop
	addi t3, x0, 0 # Counts the set bits
	addi t4, x0, 1 # t4 = 1 to compare for set bits
	addi t5, x0, 32# t5 = 32 to compare for exiting loop

loop:
	beq t2, t5, done  # if t2 = 31 then jump to done
	andi t6, t1, 1    # Extract the LSB
	srai t1, t1, 1    # Shift Right to git rid of LSB
	addi t2, t2, 1    # incrementing the loop
	beq t6, t4, count # if extracting bit is 1 then jump to count
	j loop            # jump to loop

count:
	addi t3, t3, 1 # Incrementing the count to 1
	j loop

done:
	# Spike signal to quit
	li t0, 1
	la t1, tohost
	sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
