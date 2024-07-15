.global _start 
.section .text 
#Declaring a 32_bit word
number_32bit:
.word 0x11111112
_start:

la x1,number_32bit
lw x2,0(x1)

addi x3,x0,32
addi x4,x0,1
addi x6,x0,0

loop:
beq x3,x0,end
addi x3,x3,-1
andi x5,x2,1
srli x2,x2,1
beq x5,x4,increment
j loop

increment: 
addi x6,x6,1
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
