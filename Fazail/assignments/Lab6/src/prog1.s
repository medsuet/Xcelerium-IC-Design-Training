.global _start

.section .text
_start:
    li a0, -5 # initialize
    li a1, 10 #
    li a3, -1

    sub a2, a0, a1;

check:
    bge a2, zero, end
    mul a2, a2, a3
    j end

end:
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
