# Name: problem4.s
# Author: Muhammad Tayyab
# Date: 11-7-2024
# Description: Reverse array in place

.global _start

# Define array
.section .data
array: .word 1, 2, 3, 4, 5
size: .word 5

.section .text
reverse_array:
    # Reverses array in place
    # Arguments: a0: address of array, a1: size of array

    li t2, 0                    # initialize loop counter (i)
    srli a2, a1, 1              # half the size (we only need to traverse half array)
    add t0, x0, a0              # address of ith element of array

    # Find address of last element of array
    addi t1, a1, -1             # get last index by size-1
    slli t1, t1, 2              # multiply last index by 4 to get address offset
    add t1, a0, t1              # address of (n-i)th element of array

loop:
    lw t4, 0(t0)                # load ith element
    lw t5, 0(t1)                # load (n-i)th element
    sw t4, 0(t1)                # store ith element at (n-i)th position
    sw t5, 0(t0)                # store (n-i)th element at ith position

    addi t2, t2, 1              # increment counter
    addi t0, t0, 4              # address of (next) ith element of array
    addi t1, t1, -4             # address of (previous) (n-i)th element of array
    blt t2, a2, loop            # loop while counter < half size

    ret

_start:
    la a0, array                # store address of array
    la a1, size                 # store address of size
    lw a1, 0(a1)                # store value of size
    jal ra, reverse_array       # call function

end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
