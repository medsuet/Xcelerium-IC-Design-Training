.global _start
.section .text

_start:
    la t0, array      # Load address of array
    li t1, 0          # i = 0
    li t2, 4          # size of an int (4 bytes)
    li t3, 4          # length of the array (4 elements)
    mul t4, t3, t2    # total size of array in bytes
    sub t5, t4, t2    # j = 4*4 - 4 = 12

reverse_loop:
    bge t1, t5, exit_reverse # if i >= j, exit loop

    # Load array[i] into t6
    add t6, t0, t1
    lw t6, 0(t6)

    # Load array[j] into t6 (reuse t6 for array[j])
    add t6, t0, t5
    lw t6, 0(t6)

    # Swap array[i] and array[j]
    sw t6, 0(t0)      # Store array[j] into array[i]
    sw t6, 0(t5)      # Store array[i] into array[j]

    # Increment i and decrement j
    addi t1, t1, 4
    addi t5, t5, -4

    j reverse_loop

exit_reverse:
    # Code to exit for Spike (DONT REMOVE IT)
    li t6, 1
    la t0, tohost
    sd t6, (t0)

    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

.section .data
array:   .word 1, 2, 3, 4  # Example array to reverse
