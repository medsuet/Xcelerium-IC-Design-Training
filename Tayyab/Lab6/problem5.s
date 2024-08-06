# Name: problem5.s
# Author: Muhammad Tayyab
# Date: 14-7-2024
# Description: Insertion sort array

.global _start

.eqv BLOCKSIZE, 8                   # size of a memory block (dword = 8 bytes)

# Define array
.section .data
.align 3
array: .dword 5,4,1,2,7,9,8,6,0,3
arraylength: .dword 10

.section .text
_start:
    la a0, array                    # a0: address of first element of array
    la t0, arraylength      
    ld t0, 0(t0)                    # t0: length of array
    li t1, 1                        # t1: (loop counter) number of sorted elements = 1
    add a1, a0, BLOCKSIZE           # a1: address of next element-to-sort

# Iterate through all elements of array to sort each (1st is already sorted)
loop1:      
    ld t2, 0(a1)                    # t2: current element-to-sort
    addi a2, a1, -BLOCKSIZE         # a2: address of next element-to-shift rightwards

# Shift elements larger than element-to-sort to right to make space for it
loop2:
    ld t4, 0(a2)                    # t4: next element-to-shift right
    blt  t4, t2, endloop2_1         # if t4 < element-to-sort, don't shift it and exit loop
    sw t4, BLOCKSIZE(a2)            # else save t4 at the index to its right
    beq a2, a0, endloop2            # if this element-to-shift was the first element of array, exit loop
    addi a2, a2, -BLOCKSIZE         # else point a2 to next element-to-shift
    J loop2                         # and loop again
endloop2_1:
    # When exit by `blt  t4, t2, endloop2_1`, a2 points to the next element-to-shift although
    # it wasn't shifted. So point a2 back to the last shifted element.
    addi a2, a2, BLOCKSIZE
endloop2:

    sw t2, 0(a2)                    # place element-to-sort at the space made available by shifting
    addi a1, a1, BLOCKSIZE          # point a1 to next element to sort
    addi t1, t1, 1                  # increment loop counter (number of sorted elements)
    blt t1, t0, loop1               # loop while loop counter < arraylength
endloop1:

end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
