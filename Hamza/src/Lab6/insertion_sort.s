.global _start
.section .text

_start:
    la t0, array      # Load address of array
    li t1, 4          # size of an int (4 bytes)
    li t2, 4          # length of the array (4 elements)
    add t3, t0, t1    # i = 1 (starting from the second element)

outer_loop:
    beq t3, t0, exit_sort # if i == length, exit loop
    lw t4, 0(t3)      # key = array[i]
    sub t5, t3, t1    # j = i - 1

inner_loop:
    blt t5, t0, insert_key # if j < 0, insert key
    lw t6, 0(t5)      # load array[j] into t6
    bge t6, t4, shift_element # if array[j] >= key, shift element

insert_key:
    sw t4, t5(t0)     # Store key (t4) at array[j+1]
    add t3, t3, t1    # Increment i (t3 = i + size of an int)
    j outer_loop      # Jump back to outer loop

shift_element:
    sw t6, t5(t0)     # Store array[j] (t6) at array[j+1]
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
