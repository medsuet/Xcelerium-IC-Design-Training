.global _start
.section .text

_start:
    li t0, 1  # t0 = 0 storing results
    li t1, 5  # t1 = 5 input number
    li t2, 0  # t2 = 0 counter

loop: 
    addi t2, t2, 1  # increment counter
    mul t0, t0, t2  # multiply t0 by t2

    bge t1, t2, loop # continue looping if t2 < t1

# Code to exit for Spike
li t0, 1
la t1, tohost
sd t0, 0(t1)

# Loop forever if spike does not exit
1: j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
