.section .text
.global _start

_start:
    addi t0, x0, 0
    la t1, array
    la t2, size
    lw t3, 0(t2)
    srli t4, t3, 1

loop:
    beq t0, t4, end_loop
    lw t5, 0(t1)
    addi t3, t3, -1
    slli t6, t3, 2
    add t7, t1, t6
    lw t8, 0(t7)
    sw t8, 0(t1)
    sw t5, 0(t7)
    addi t1, t1, 4
    addi t0, t0, 1
    j loop

end_loop:
    li a0, 1
    la a1, tohost
    sd a0, 0(a1)
1:  j 1b

.section .data
array: .word 1, 2, 3, 4, 5
size: .word 5

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
