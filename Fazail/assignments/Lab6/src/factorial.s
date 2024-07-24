.data
value: .word 5

.section .text

.global _start
_start:
    la t0, value
    lw t0, 0(t0)

    li s0, 1
    li s2, 1

factorial:
    blt t0, s0, end
    mul s2, s2, t0
    sub t0, t0, s0
    j factorial

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
