.global _start
.section .text

_start:
    la t0, num
    lw t1, 0(t0)     # Load number into t1

    la t0, result

factorial_loop:
    beqz t1, done    # If t1 is 0, done
    mul t2, t1, t2   # result = result * t1
    sw t2, 0(t0)     # Store the result
    addi t1, t1, -1  # t1 = t1 - 1
    j factorial_loop # Repeat

done:
    # Code to exit for Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

.section .data
num:    .word 5      # Number to compute factorial for
result: .word 1      # Initialize result to 1
