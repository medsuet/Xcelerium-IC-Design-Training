.section .text

.global _start
end:
    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, (t1)

    # Loop forever if spike does not exit
1: j 1b

clr_bit:
    mv t3, s0

    sll t0, t4, t1
    xor t1, t0, -1
    and t3, t3, t1

    mv s0, t3

    ret

set_bit:
    mv t3, s0

    sll t0, t4, t0
    or t3, t3, t0

    mv s0, t3

    ret

_start:
    # Initialize the registers
    li s0, 10       # value = 10 --> 1010
    li t0, 2        # setbit = 2
    li t1, 3        # clrbit = 3
    li t4, 1        # temporary value i = 1

    call set_bit

    call clr_bit

    j end

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
