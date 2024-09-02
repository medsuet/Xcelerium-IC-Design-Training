.section .data
number:       .word 5             # Example value: 5; this is the number to modify
bitLocation:  .word 1             # Example value: 1; the bit position to set or clear
operation:    .word 1             # 1 for set, 0 for clear; determines the operation to perform

.section .text
.globl _start

_start:
    la t0, number            # Load the address of 'number' into register t0
    lw t1, 0(t0)             # Load the value of 'number' into register t1

    la t0, bitLocation       # Load the address of 'bitLocation' into register t0
    lw t2, 0(t0)             # Load the value of 'bitLocation' into register t2

    la t0, operation         # Load the address of 'operation' into register t0
    lw t3, 0(t0)             # Load the value of 'operation' into register t3

    li t4, 1                 # Load immediate value 1 into register t4
    sll t4, t4, t2           # Shift left t4 by the number of bits in 'bitLocation' to create the bitmask

    beq t3, zero, clear_bit  # If 'operation' is 0 (clear), branch to clear_bit label

set_bit:
    or t1, t1, t4            # OR the original number with the bitmask to set the specified bit
    j end                    # Jump to end to skip the clear_bit section

clear_bit:
    not t4, t4                # Invert the bitmask to create a mask for clearing the bit
    and t1, t1, t4            # AND the original number with the inverted mask to clear the specified bit

end:
    la t0, number            # Load the address of 'number' into register t0
    sw t1, 0(t0)             # Store the modified value of 'number' back to memory

    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1                 # Load immediate value 1 into register t0 (exit code)
    la t1, tohost            # Load the address of 'tohost' into register t1
    sd t0, (t1)              # Store the exit code into the 'tohost' address
    # Loop forever if Spike does not exit
1:  j 1b                    # Jump to the start of this loop to prevent exiting the simulator

.section .tohost
.align 3
tohost: .dword 0            # Define a 64-bit word for Spike to handle exit codes
fromhost: .dword 0          # Define a 64-bit word for potential communication from host
