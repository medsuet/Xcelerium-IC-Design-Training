.section .data
# Define the 32-bit number and the bit positions
num:    .word 0x12345678       # Example number
bit_pos: .word 3               # Bit position to modify (0-based)

.section .text
.global _start

_start:
    # Set the bit at position `bit_pos` in `num`
    la a0, num              # Load address of num into a0
    la a1, bit_pos          # Load address of bit_pos into a1
    lw a1, 0(a1)            # Load bit_pos value into a1
    call set_bit            # Call set_bit function
    
    # Clear the bit at position `bit_pos` in `num`
    la a0, num              # Load address of num into a0
    la a1, bit_pos          # Load address of bit_pos into a1
    lw a1, 0(a1)            # Load bit_pos value into a1
    call clear_bit          # Call clear_bit function
    j end

# Function to set a bit
set_bit:
    lw t0, 0(a0)            # Load the 32-bit number into t0
    li t1, 1                # Load 1 into t1
    sll t1, t1, a1          # t1 = 1 << a1
    or t0, t0, t1           # t0 = t0 | t1 (set the bit)
    sw t0, 0(a0)            # Store the updated number back
    ret                     # Return from the function

# Function to clear a bit
clear_bit:
    lw t0, 0(a0)            # Load the 32-bit number into t0
    li t1, 1                # Load 1 into t1
    sll t1, t1, a1          # t1 = 1 << a1
    not t1, t1              # t1 = ~t1
    and t0, t0, t1          # t0 = t0 & t1 (clear the bit)
    sw t0, 0(a0)            # Store the updated number back
    ret                     # Return from the function

end:
    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, 0(t1)
    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
