.section .data
    array:  .word 1, 2, 3, 4, 5  # Define an array with 5 elements
    size:   .word 5              # Define the size of the array

.section .text
.globl _start

_start:
    la t0, array    # Load the address of the array into t0
    la t1, size     # Load the address of size into t1
    lw t2, 0(t1)    # Load the size of the array into t2

    # Load the first and last elements before reversing
    lw t3, 0(t0)         # Load first element into t3
    slli t4, t2, 2       # Calculate offset for the last element (size * 4)
    add t4, t0, t4       # Address of array[size]
    addi t4, t4, -4      # Address of array[size-1]
    lw t5, 0(t4)         # Load last element into t5

    # Reverse the array
    li t6, 0        # Initialize left index to 0
    add s0, t2, zero  # Initialize right index to size
    addi s0, s0, -1 # Adjust right index to point to the last element

reverse_loop:
    bge t6, s0, print_reversed # If left index >= right index, exit loop

    # Calculate addresses of array[left] and array[right]
    slli s1, t6, 2  # Calculate offset for left index (left * 4)
    add s2, t0, s1  # Address of array[left] = base address + left offset
    lw s3, 0(s2)    # Load array[left] into s3

    slli s4, s0, 2  # Calculate offset for right index (right * 4)
    add s5, t0, s4  # Address of array[right] = base address + right offset
    lw s6, 0(s5)    # Load array[right] into s6

    # Swap array[left] and array[right]
    sw s6, 0(s2)    # Store array[right] at array[left]
    sw s3, 0(s5)    # Store array[left] at array[right]

    addi t6, t6, 1  # Increment left index

    addi s0, s0, -1 # Decrement right index

    j reverse_loop  # Jump back to the start of the loop

print_reversed:
    # Load the first and last elements after reversing
    lw s7, 0(t0)         # Load first element into s7
    lw s8, 0(t4)         # Load last element into s8


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
