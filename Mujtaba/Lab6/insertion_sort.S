.section .data
array: .word 5, 3, 8, 4, 2, 7, 1, 10, 9, 6  # Example array
size:  .word 10                             # Size of the array

.section .text
.global _start

_start:
    la t0, array       # Load address of the array into t0
    lw t1, size        # Load size of the array into t1

    addi t2, x0, 1     # t2 = 1 (index j starts from 1)
outer_loop:
    beq t2, t1, done   # if j == size, done
    slli t3, t2, 2     # t3 = j * 4 (offset in bytes for 32-bit word)
    add t4, t0, t3     # t4 = &array[j]
    lw t5, 0(t4)       # t5 = array[j]

    addi t6, t2, -1    # t6 = j - 1
inner_loop:
    slli s7, t6, 2     # s7 = (j - 1) * 4
    add s8, t0, s7     # s8 = &array[j-1]
    lw s9, 0(s8)       # t9 = array[j-1]
    bge s9, t5, insert # if array[j-1] >= array[j], insert

    sw s9, 4(s8)       # array[j] = array[j-1]
    addi t6, t6, -1    # j = j - 1
    blt t6, x0, insert # if j < 0, insert
    j inner_loop

insert:
    slli s7, t6, 2     # s7 = j * 4 (new offset)
    add s8, t0, s7     # s8 = &array[j]
    sw t5, 4(s8)       # array[j] = key
    addi t2, t2, 1     # j = j + 1
    j outer_loop

done:
    # Spike signal to quit
	li t0, 1
	la t1, tohost
	sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
