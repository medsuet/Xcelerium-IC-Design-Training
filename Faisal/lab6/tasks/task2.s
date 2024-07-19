# x10: input number
# x11: bit position (0-31)
# x12: control flag (0: clear, 1: set)
# x13: output number

.global _start

_start:
    li x12, 1          # check control flag
    li x13, 1          # Load 1 into x13 
    li x10, 1          # Load input number 
    sll x13, x13, 1    # Shift left to create bitmask ( bit position)
    beq x12, x0, clear   # check control flag If control flag is 0, clear bit otherwise set bit
    or x13, x10, x13     # Set bit
    j end

clear:
    not x13, x13         # Invert bitmask
    and x13, x10, x13    # Clear bit

end:

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
