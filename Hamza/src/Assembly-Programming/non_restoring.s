.section .data
dividend:   .word 123     # Dividend
divisor:    .word 5       # Divisor 
Q:          .word 0       # Q to 0 (quotient)
M:          .word 0       # M to 0 (remainder)

.section .text
.global _start

_start:
    # Load dividend into register t0
    la t1, dividend       # Load address of dividend into t1
    lw t0, 0(t1)          # Load value at address in t1 into t0 (Q)

    # Load divisor into register t2
    la t1, divisor        # Load address of divisor into t1
    lw t2, 0(t1)          # Load value at address in t1 into t2 (M)

    # Initialize remainder (A) to 0
    li t3, 0              # A = 0

    # Set loop counter for 32 iterations
    li t4, 32

div_loop:
    # Shift A and Q left by 1
    slli t3, t3, 1        # Shift A left by 1
    srli t5, t0, 31       # Get the MSB of Q
    or t3, t3, t5         # Combine it with A
    slli t0, t0, 1        # Shift Q left by 1

    # Subtract M from A
    sub t3, t3, t2

    # Check if the new A is negative
    bgez t3, pos_case

    # If A is negative, restore A and set Q[0] to 0
    add t3, t3, t2        # Restore A
    j end_loop

pos_case:
    # If A is positive, set Q[0] to 1
    ori t0, t0, 1

end_loop:
    # Decrement loop counter and continue if not zero
    addi t4, t4, -1
    bnez t4, div_loop

    # Store the quotient and remainder
    la t1, Q
    sw t0, 0(t1)          # Store quotient in Q
    la t1, M
    sw t3, 0(t1)          # Store remainder in M

    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, 0(t1)

    # Loop forever if Spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
