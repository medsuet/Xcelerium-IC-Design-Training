.section .text
.global _start
_start:
    addi t2,x0,1
    la t0, array
    mv x3,t0
    la t6, size
    lw x1, (t6)
cond:
    blt t2, x1, loop
    j end
loop:
    mv t3,t0
    lw t4, (t3)
    addi t0,t0,4
    mv t5,t0
    lw t1, (t0)
    addi t2,t2,1
    j index_check
index_check:
    bge t3,x3,comparing
    j no_swap
comparing:
    bgt t4,t1,sort
    j no_swap
sort:
    sw t4, (t5)
    addi t3,t3,-4
    lw t4, (t3)
    addi t5,t5,-4
    j index_check
no_swap:
    addi t3,t3,4
    sw t1, (t3)
    j cond
end:
    li t0,1
    la t1, tohost
    sd t0, (t1)
1: j 1b

.section .data
array: .word 5,3,2,4,1
size: .word 5

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
