.global _start

.section .data
    # Data section to store the numbers
    num: .word 5
    fact: .word 1
    i: .word 5

.section .text
_start:
    la t0, num
    lw t1, 0(t0) # t1 = num
    la t0, fact  # t2 = fact
    lw t2, 0(t0)
    la t0, i     # t3 = i;
    li t4, 1
    lw t3, 0(t0)
check:
    bgt t3, t4, target # if t3 > t4 (i>1) then target
    
    la t0, fact
    sw t2, 0(t0)
    
target:
    mul t2, t2, t3 check # t0 = t1 + t2
    







    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, (t1)

    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
