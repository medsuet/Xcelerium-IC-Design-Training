# Lab 5 : Problem 1
# Assembly code to calculate absolute difference between two numbers

.global _start

.section .text
_start:
    li a1, 2
    li a2, 5
    blt a1, a2, other
    sub a3, a1, a2          # Action a3=a1-a2 if a1 > a2,
    j end
other:
    sub a3, a2, a1          # Action a3=a2-a1 if a1 < a2 

end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
