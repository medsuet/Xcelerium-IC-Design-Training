.section .text
.global _start
_start:
    addi x7,x0,0
    addi x8,x0,4
    la x1, array
    addi x11,x1,0
    addi x7,x0,0
    la x3, size
    lw x4, (x3)
    srli x6,x4,1
loop:
    lw x2, (x1)
    addi x4,x4,-1
    mul x9,x4,x8
    add x10,x11,x9
    lw x5,(x10) 
    beq x7,x6,end
    addi x7,x7,1
swap:
    sw x5, (x1)
    sw x2, (x10)
    addi x1,x1,4
    j loop
end:
    li t0,1
    la t1, tohost
    sd t0, (t1)
1: j 1b

.section .data
array: .word 1,2,3,4,5
size: .word 5

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

