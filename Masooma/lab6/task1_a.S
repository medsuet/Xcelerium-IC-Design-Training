.global _start
.section .text
_start:
    addi x1,x0,10
    addi x2,x0,12
    blt x1,x2,less_than
    sub x4,x1,x2
less_than:
    sub x4,x2,x1
    j end
end:
    li t0,1
    la t1, tohost
    sd t0, (t1)
1: j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
