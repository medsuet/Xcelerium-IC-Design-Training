.data
array: .word 1, 3, 6, 10, 9, 5, 7
size: .word 7

.section .text

.global _start
_start:
    la t0, array        # starting address of array
    lw t1, size         # length of the array

    #li t2, 4            # storing 4 because of word addressable
    #mul t1, t1, t2      # total size of the array

    slli t1, t1, 2
    addi t1, t1, -4

    add t1, t1, t0      # last address of the array

loop:
    lw a0, 0(t0)        # first element of the array (1st iteration)
    lw a1, 0(t1)        # last element of the array (1st iteration)

    sw a1, 0(t0)        # store last element in the starting address
    sw a0, 0(t1)        # store first element in the last addres

    addi t0, t0, 4      # increase by 4 from first
    addi t1, t1, -4     # decrease by 4 from last

    bgt t1, t0, loop

end:
    li t0, 1
    la t1, tohost
    sd t0, 0(t1)

1: j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
