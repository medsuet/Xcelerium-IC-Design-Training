.global _start

.section .data
    # Data section to store the numbers
    num1: .word 15
    num2: .word 10
    result: .word 0

.section .text
_start:
    # Load numbers into registers
    la t0, num1
    lw t1, 0(t0)
    la t0, num2
    lw t2, 0(t0)

    # Calculate the difference
    sub t3, t1, t2  # t3 = t1 - t2

    # Check if the result is negative
    bgez t3, positive  # If t3 >= 0, jump to positive

    # If the result is negative, negate it
    neg t3, t3 # sub t3, zero, t3 (t3 = 0 +(~t3)) 

positive:
    # Store the result
    la t0, result
    sw t3, 0(t0)

    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, (t1)

    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
