.global _start

.section .text

_start:

li a1, 10
li a2, 7
li x0, 0

sub a3, a1, a2

blt a3, x0, NEG
 break
NEG:
    neg a3, a3

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

