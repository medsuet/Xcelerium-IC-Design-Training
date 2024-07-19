    .data
dividend: .word 5        # Dividend
divisor:  .word 2        # Divisor
quotient: .word 0        # Quotient (result)
remainder:.word 0        # Remainder (result)

    .text
    .globl _start

_start:
    # Load the dividend and divisor
    la t0, dividend
    lw t1, 0(t0)         # t1 = dividend
    la t0, divisor
    lw t2, 0(t0)         # t2 = divisor

    # Initialize registers
    li t3, 0             # A = 0
    li t4, 32            # N = 32 (number of bits)

division_loop:
    # Check if N == 0
    beqz t4, end_loop

    # Shift left A and Q
    slli t5, t3, 1       # t5 = A << 1
    srli t6, t1, 31      # t6 = Q[31] (get the MSB of Q)
    or t5, t5, t6        # A = (A << 1) | Q[31]
    slli t1, t1, 1       # Q = Q << 1

    # A = A - M
    add t3, t5, -t2       # A = A - M

    # Check if A < 0
    bltz t3, restore_A
    # A >= 0, set Q[0] to 1
    ori t1, t1, 1
    j decrement_n

restore_A:
    # A < 0, set Q[0] to 0 and restore A
    andi t1, t1, ~1      # Q[0] = 0
    add t3, t3, t2       # A = A + M (restore A)

decrement_n:
    addi t4, t4, -1      # N = N - 1
    j division_loop

end_loop:
    # Store the quotient and remainder
    la t0, quotient
    sw t1, 0(t0)         # Store quotient
    la t0, remainder
    sw t3, 0(t0)         # Store remainder

# Code to exit for Spike (DONT REMOVE IT)
li t0, 1
la t1, tohost
sd t0, (t1)
# Loop forever if spike does not exit
1: j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
