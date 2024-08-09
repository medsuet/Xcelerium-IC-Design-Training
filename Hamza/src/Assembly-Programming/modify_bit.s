.global _start
.section .text

_start:
    # Load inputs
    li t0, 156
    li t1, 5        # Bit position to modify
    li t2, 1        # Action (1 = set, 0 = clear)

    # Compute bit mask
    li t3, 1         # Load 1 into t3
    sll t3, t3, t1   # Shift 1 left by the bit position in t1 to create the mask

    # Check action and modify the bit
    beqz t2, clear_bit   # If t2 is 0, jump to clear_bit

set_bit:
    or t0, t0, t3    # Set the bit using OR operation
    j end            # Jump to end

clear_bit:
    not t3, t3       # Invert the mask
    and t0, t0, t3   # Clear the bit using AND operation

end:
    # Code to exit for Spike (DONT REMOVE IT)
    li t6, 1
    la t1, tohost
    sd t6, (t1)

    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
