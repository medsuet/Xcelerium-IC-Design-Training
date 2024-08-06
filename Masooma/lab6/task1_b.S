.section .text
.global _start
_start:
    addi x1,x0,12
    addi x4,x0,0
    addi x2,x0,1
    addi x6,x0,0
    addi x5,x0,32
calculation:
    and   x3,x1,x2
    beq x3,x2,counter
shift:
    srli x1,x1,1
    addi x6,x6,1
    bne x6,x5,calculation
    j end
counter:
    addi x4,x4,1
    j shift
end:
    li t0,1
    la t1, tohost
    sd t0, (t1)
1: j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
