.section .data
    array:  .word 5, 3, 4, 1, 2  # Define an array with 5 elements
    size:   .word 5              # Define the size of the array

.section .text
.globl _start

_start:
    la t0, array    # Load the address of the array into t0
    la t1, size     # Load the address of size into t1
    lw t2, 0(t1)    # Load the size of the array into t2

    addi t3, t0, 4  # t3 = address of array[1]

outer_loop:
    bge t3, t0, outer_done # if t3 >= address of array[size], exit outer loop
    lw t4, 0(t3)           # key = array[i]
    add t5, t3, zero       # j = i

inner_loop:
    addi t5, t5, -4        # j = j - 1
    blt t5, t0, insert_key # if j < address of array[0], insert key
    lw t6, 0(t5)           # temp = array[j]
    bge t6, t4, insert_key # if array[j] >= key, insert key
    addi s0, t5, 4         # address of array[j + 1]
    sw t6, 0(s0)           # array[j + 1] = array[j]
    j inner_loop           # repeat inner loop

insert_key:
    addi t5, t5, 4         # address of array[j + 1]
    sw t4, 0(t5)           # array[j + 1] = key
    addi t3, t3, 4         # i = i + 1
    blt t3, t0, outer_done # if t3 >= address of array[size], exit outer loop
    j outer_loop           # repeat outer loop

outer_done:

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
