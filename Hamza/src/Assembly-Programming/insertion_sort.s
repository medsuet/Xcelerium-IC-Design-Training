.global _start
.section .text

_start:
    la t0, array      # Load address of array
    li t1, 4          # size of an int (4 bytes)
    li t2, 16         # size of the array in bytes (4 elements * 4 bytes each)
    add t3, t0, t1    # i = 1 (starting from the second element)

outer_loop:
    beq t3, t2, exit_sort # if t3 == end of array, exit loop
    lw t4, 0(t3)      # key = array[i]
    sub t5, t3, t1    # j = i - 1

inner_loop:
    blt t5, t0, insert_key # if j < array base address, insert key
    lw t6, 0(t5)      # load array[j] into t6
    bge t6, t4, shift_element # if array[j] >= key, shift element

insert_key:
    add t6, t5, t1    # Calculate address: t5 (j) + 4
    sw t4, 0(t6)      # Store key (t4) at array[j+1]
    add t3, t3, t1    # Increment i (t3 = i + size of an int)
    j outer_loop      # Jump back to outer loop

shift_element:
    add t6, t5, t1    # Calculate address: t5 (j) + 4
    sw t6, 0(t6)      # Store array[j] (t6) at array[j+1]
    sub t5, t5, t1    # Decrement j (t5 = j - size of an int)
    j inner_loop      # Jump back to inner loop

exit_sort:
    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, (t1)

    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

.section .data
array:   .word 4, 3, 2, 1  # Example array to sort
