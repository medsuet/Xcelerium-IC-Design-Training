.global _start 
.section .text
Dividend:
    .word 18
Divisor:
    .word 6
num_bits:
    .word 32

_start:
    la x1,Dividend
    lw x2,0(x1)    #Q
    la x1,Divisor  
    lw x3,0(x1)    #M
    addi x4,x0,0   #A
    addi x10,x4,0   #A_res
    la x1,num_bits
    lw x5,0(x1)    #N
    addi x6,x0,1
    slli x6,x6,31 #BitChecking_31
loop:
    beq x5,x0,end
    slli x4,x4,1
    addi x10,x4,0
    sub x4,x4,x3
    and x7,x2,x6
    beq x7,x0,MSB_of_A_is_0
MSB_of_A_is_1:
    li x12, -2
    and x2,x2,x12
    addi x4,x10,0
    j next
MSB_of_A_is_0:
    or x2,x2,1
next:
    addi x5,x5,-1
    j loop

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
