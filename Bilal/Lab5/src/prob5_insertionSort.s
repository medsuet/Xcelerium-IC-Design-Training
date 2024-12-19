# Problem No. 5
# Insertion sort array

.global _start

.eqv BLOCKSIZE, 8                   # 8 bytes of a memory block

# Define array
.section .data
.align 3
array: .dword 5,4,1,2,7,9,8,6
arraylength: .dword 8

.section .text
_start:
    la a0, array                    # a0: address of first element of array
    la x0, arraylength      
    ld x0, 0(x0)                    # x0: length of array
    li x1, 1                        # x1: (loop counter) number of sorted elements = 1
    add a1, a0, BLOCKSIZE           # a1: address of next element-to-sort

# Iterate through all elements of array to sort each (1st is already sorted)
loop1:      
    ld x2, 0(a1)                    # x2: current element-to-sort
    addi a2, a1, -BLOCKSIZE         # a2: address of next element-to-shift rightwards

loop2:
    ld t4, 0(a2)                    # t4: next element-to-shift right
    blt  t4, x2, endloop21          # if t4 < element-to-sort, don't shift it and exit loop
    sw t4, BLOCKSIZE(a2)            # else save t4 at the index to its right
    beq a2, a0, endloop2            # if this element-to-shift was the first element of array, exit loop
    addi a2, a2, -BLOCKSIZE         # else point a2 to next element-to-shift
    J loop2                         # and loop again
endloop21:
    addi a2, a2, BLOCKSIZE
endloop2:

    sw x2, 0(a2)                    # place element-to-sort at the space made available by shifting
    addi a1, a1, BLOCKSIZE          # point a1 to next element to sort
    addi x1, x1, 1                  # increment loop counter (number of sorted elements)
    blt x1, x0, loop1               # loop while loop counter < arraylength
endloop1:

end:
    # Signal test pass to Spike
    li x0, 1
    la x1, tohost
    sd x0, (x1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
