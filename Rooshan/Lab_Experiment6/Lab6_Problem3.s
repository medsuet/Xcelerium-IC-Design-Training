.global _start 
  
.section .text 
_start:
    addi x1,x0,1
    addi x5,x0,2
    blt x1,x5,Num_either_0_or_1
    addi x4,x1,0
    addi x1,x1,1
    addi x3,x0,0
    j Factorial

Num_either_0_or_1:
    addi x4,x0,1
    j end

Factorial:
    addi x1,x1,-1
    addi x2,x1,-1
    beq x2,x0,end

Multiply:
    addi x2,x2,-1
    add x3,x3,x4
    bne x2,x0,Multiply
    addi x4,x3,0
    add x3,x0,x0
    j Factorial

end:
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
