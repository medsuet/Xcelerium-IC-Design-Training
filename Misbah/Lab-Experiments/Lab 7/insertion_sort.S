.section .text
.global _start

_start:
    addi t0, x0, 1
    la t1, array
    mv t2, t1
    la t3, size
    lw t4, 0(t3)

cond:
    blt t0, t4, loop
    j end

loop:
    mv t5, t1
    lw t6, 0(t5)
    addi t1, t1, 4
    mv t7, t1
    lw t8, 0(t7)
    addi t0, t0, 1
    j index_check

index_check:
    bge t5, t2, comparing
    j no_swap

comparing:
    bgt t6, t8, sort
    j no_swap

sort:
    sw t6, 0(t7)
    addi t5, t5, -4
    lw t6, 0(t5)
    addi t7, t7, -4
    j index_check

no_swap:
    addi t5, t5, 4
    sw t8, 0(t5)
    j cond

end:
    li a0, 1
    la a1, tohost
    sd a0, 0(a1)
1:  j 1b

.section .data
array: .word 5, 7, 9, 56, 1
size: .word 5

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
