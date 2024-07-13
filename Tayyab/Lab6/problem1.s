# Name: problem1.s
# Author: Muhammad Tayyab
# Date: 11-7-2024
# Description: Calculate absolute difference between two numbers

.global _start

.section .text
_start:
    li x1, 2
    li x2, 5
    blt x1, x2, other
    sub x3, x1, x2          # if x1 > x2, x3=x1-x2
    j end
other:
    sub x3, x2, x1          # if x1 < x2, x3=x2-x1

end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
