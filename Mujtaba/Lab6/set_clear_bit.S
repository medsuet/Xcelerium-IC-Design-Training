.section .data
number:     .word 0x12345678  # Example 32-bit number
bit_index:  .word 4           # Example bit index (0-31)
operation:  .word 0           # Operation: 0 = clear, 1 = set

.text
.global _start

_start:
    # Load the number, bit index, and operation
    lw t0, number         # t0 = number
    lw t1, bit_index      # t1 = bit index
    lw t2, operation      # t2 = operation

    # Check if operation is set (1) or clear (0)
    beq t2, zero, clear_bit
    j set_bit

set_bit:
    # Set the bit at the specified index
    li t3, 1             # t3 = 1
    sll t3, t3, t1       # t3 = 1 << bit_index
    or t0, t0, t3        # number |= t3
    j end

clear_bit:
    # Clear the bit at the specified index
    li t3, 1             # t3 = 1
    sll t3, t3, t1       # t3 = 1 << bit_index
    not t3, t3           # t3 = ~(1 << bit_index)
    and t0, t0, t3       # number &= t3

end:
    # Store the result back to the memory
	la t1, number
    sw t0, 0(t1)

    # Spike signal to quit
	li t0, 1
	la t1, tohost
	sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0 
