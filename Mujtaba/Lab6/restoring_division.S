.section .data
dividend: .word 42     # Example dividend
divisor:  .word 5      # Example divisor

.text
.global _start

_start:
    # Load the dividend and divisor
    lw t0, dividend      # t0 = dividend = Q
    lw t1, divisor       # t1 = divisor = M

    # Initialize remainder
    li t3, 0             # t3 = A = remainder = 0
	
	# Determine the number of bits in the dividend
    li t4, 32            # t4 = number of bits

divide_loop:
	# Combined Left shift the remainder (A) and the dividend (Q)
    sll t3, t3, 1            # A << 1
	li s3, 0x80000000
	and s1, t0, s3           # s1 = Q & 0x80000000
	srai s1, s1, 31			 # s1 >> 31
	or t3, t3, s1			 # A = s1 | t3
    sll t0, t0, 1            # Q << 1

	# A = A - M
	sub t3, t3, t1
	
	# if t3 < 0 then restore_remainder
	bltz t3, restore_remainder
	or t0, t0, 1     # else
	addi t4, t4, -1
	beqz t4, end
	j divide_loop

restore_remainder:
    li s1, 1
	not s1, s1
	and t0, t0, s1	# Q = Q & ~1
	add t3, t3, t1  # Restore A -> A = A + M
	addi t4, t4, -1
    beqz t4, end
	j divide_loop

    # At this point, t2 = quotient and t3 = remainder
end:
	# Spike signal to quit
	li s0, 1
	la t1, tohost
	sd s0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
