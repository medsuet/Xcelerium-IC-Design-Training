.section .text
.global _start
_start:
    addi x1,x0,1
    add x3,x0,1
    ble x1,x3,base
    add x4,x0,x1
    add x2,x0,x1
fictorial:
    addi x2,x2,-1
    add x5,x2,x0
    bgt x2,x3,multiply
    j end
multiply:
    add x4,x4,x1
    addi x5,x5,-1
    bne x5,x3,multiply
    mv x1,x4
    j fictorial
base:
    addi x4,x0,1
end:
    li t0,1
    la t1, tohost
    sd t0, (t1)
1: j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

