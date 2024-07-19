.section .text
.global _start
_start:
    addi x1,x0,12
    addi x2,x0,3
    addi x3,x0,0
    addi x4,x0,32
    addi x10,x0,1
    addi x8,x0,0
cond:
    bgt x4,x0,loop
    j end
loop:
    slli x12,x3,1
    srli x5,x1,31
    or x3,x12,x5
    slli x1,x1,1
    sub x3,x3,x2
    slli x11,x10,31
    and x7,x3,x11
    addi x4,x4,-1
    bne x7,x0,state1
    j state2
state1:
    add x3,x3,x2
    xori x9,x8,-1
    slli x13,x9,1
    and x1,x1,x13
    j cond
state2:
    or x1,x1,x10
    j cond
end:
    li t0,1
    la t1, tohost
    sw t0, (t1)
1: j 1b

.section .tohost
.align 2
tohost: .dword 0
fromhost: .dword 0
