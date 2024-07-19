.section .text
.global _start
_start:
    addi x1,x0,16
    addi x2,x0,5
    addi x3,x0,0
    addi x4,x0,1
    slli x5,x4,31
    addi x6,x0,32
    xori x9,x2,-1
    addi x9,x9,1
cond:
    bgt x6,x0,loop
    and x10,x5,x3
    bne x10,x0,jump
    j end
loop:
    addi x6,x6,-1
    and x10,x5,x3
    slli x7,x3,1
    srli x8,x1,31
    or x3,x7,x8
    slli x1,x1,1
    beq x10,x0,cond_msb_first
    add x3,x3,x2
cond_sec:
    and x10,x5,x3
    beq x10,x0,cond_msb_sec
    xori x11,x4,-1
    and x1,x1,x11
    j cond
cond_msb_first:
    add x3,x3,x9
    j cond_sec
cond_msb_sec:
    or x1,x1,1
    j cond
jump:
    add x3,x3,x2
end:
    li t0,1
    la t1, tohost
    sw t0, (t1)
1: j 1b
.section .tohost
.align 2
tohost: .dword 0
fromhost: .dword 0



    