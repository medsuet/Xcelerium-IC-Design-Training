.global _start
.section .data
number:      .dword 0x12345678  # Example 32-bit number stored in 64-bit space
bit_pos:     .dword 5           # Bit position to be set/cleared (0-based index)
action:      .dword 1           # Action (1 for set, 0 for clear)

.section .text
_start:
    # Load inputs
    la t0, number      # Load address of number
    ld t1, 0(t0)       # Load the 32-bit number into t1

    la t2, bit_pos     # Load address of bit position
    ld t3, 0(t2)       # Load the bit position into t3

    la t4, action      # Load address of action
    ld t5, 0(t4)       # Load the action into t5

    # Calculate the bit mask
    li t6, 1           # Load 1 into t6
    sll t6, t6, t3     # Shift left t6 by bit position (t3)

    # Perform the action (set or clear the bit)
    beqz t5, clear_bit # If action is 0, jump to clear_bit
    or t1, t1, t6      # Set the bit (OR operation)
    j done             # Jump to done

clear_bit:
    not t6, t6         # Invert the bit mask
    and t1, t1, t6     # Clear the bit (AND operation with inverted mask)

done:
    # Store the result back into memory
    sd t1, 0(t0)

    # Exit program (for Spike simulator)
    li a0, 1
    la a1, tohost
    sd a0, 0(a1)
1:  j 1b               # Infinite loop to end program

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
