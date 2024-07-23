.global _start
.section .text

_start:
    la t0, num1     # Load address of num1
    lw t1, 0(t0)    # Load value of num1 into t1

    la t0, num2     # Load address of num2
    lw t2, 0(t0)    # Load value of num2 into t2

    sub t3, t1, t2  # t3 = t1 - t2
    bgez t3, store  # If t3 >= 0, branch to store
    neg t3, t3      # Otherwise, t3 = -t3

store:
    la t0, result
    sw t3, 0(t0)    # Store the result

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
num1:   .word 5
num2:   .word 10
result: .word 0
