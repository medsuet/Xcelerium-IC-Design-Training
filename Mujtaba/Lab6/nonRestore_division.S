.section .data
dividend: .word 42     # Example dividend
divisor:  .word 5      # Example divisor

.text
.global _start

_start:
    # Load the dividend and divisor
    lw t0, dividend      # t0 = dividend = Q
    lw t1, divisor       # t1 = divisor = M

    # Initialize remainder (A)
    li t3, 0             # t3 = remainder (A) = 0

    # Determine the number of bits in the dividend
    li t4, 32            # t4 = N = number of bits in the dividend

divide_loop:
    # Combined Left shift the remainder (A) and the dividend (Q)
    sll t3, t3, 1            # A << 1
	li s3, 0x80000000
	and s1, t0, s3           # s1 = Q & 0x80000000
	srai s1, s1, 31			 # s1 >> 31
	or t3, t3, s1			 # A = s1 | t3
    sll t0, t0, 1            # Q << 1

	
	# Check the sign of A
	blt t3, zero, add_divisor # if t3<0 then add_divisor
	sub t3, t3, t1			  # else A = A - M

resume:
	# Set the Q[0]
	blt t3, zero, set_q0
	ori t0, t0, 1
	addi t4, t4, -1
	beqz t4, final_adjust
	j divide_loop

add_divisor:
    # If sign bit is 1, A = A + M
    add t3, t3, t1       # A = A + M
	j resume

set_q0:
    # Q(0) = 0
	li s2, 1    # s2 = 1
	not s2, s2  # s2 = ~s2
	and t0, t0, s2
	addi t4, t4, -1
	beqz t4, final_adjust
	j divide_loop

final_adjust:
    # Adjust the remainder if negative
    blt zero, t3, end       # A = A + M
	add t3, t3, t1 
    j end

end:
    # Spike signal to quit
	li s0, 1
	la t1, tohost
	sd s0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
