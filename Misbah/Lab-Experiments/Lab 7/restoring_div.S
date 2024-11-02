.section .text
.global _start

_start:
    addi t1, x0, 12
    addi t2, x0, 3
    addi t3, x0, 0
    addi t4, x0, 32
    addi t5, x0, 1
    addi t6, x0, 0

cond:
    bgt t4, x0, loop
    j end

loop:
    slli t7, t3, 1
    srli t8, t1, 31
    or t3, t7, t8
    slli t1, t1, 1
    sub t3, t3, t2
    slli t9, t5, 31
    and t10, t3, t9
    addi t4, t4, -1
    bne t10, x0, state1
    j state2

state1:
    add t3, t3, t2
    xori t11, t6, -1
    slli t12, t11, 1
    and t1, t1, t12
    j cond

state2:
    or t1, t1, t5
    j cond

end:
    li a0, 1
    la a1, tohost
    sw a0, 0(a1)
1:  j 1b

.section .tohost
.align 2
tohost: .dword 0
fromhost: .dword 0
