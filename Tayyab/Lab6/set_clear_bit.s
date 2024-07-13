# Name: set_clear_bit.s
# Author: Muhammad Tayyab
# Date: 13-7-2024
# Description: Set or clear any bit in a 32 bit number


.global _start

.section .text

setbit:
    # Sets specified bit in number to 1
    # Arguments: a0: number     a1: bit number (31:0)
    # Output: a0: modifed number
    # Returns to ra
    li t0, 1
    sll t0, t0, a1
    or a0, a0, t0
    ret

clearbit:
    # Sets specified bit in number to 0
    # Arguments: a0: number     a1: bit number (31:0)
    # Output: a0: modifed number
    # Returns to ra
    li t0, 1
    sll t0, t0, a1
    not t0, t0
    and a0, a0, t0
    ret

_start:
    # Initialize registers
    li a0, 8
    li a1, 1        # set bit 1 to 1: a0 becomes 0xA
    call setbit        # call function

    li a1, 3        # set bit 3 to 0: a0 becomes 2
    jal ra, clearbit      # call function

end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
