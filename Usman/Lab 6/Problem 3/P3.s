.global _start
.section .text

_start:
   li x1, 5
   li x3, 0
   li x0, 0
   li x2, 5

addi x2, x2, -1 
mul x3, x1, x2
repeat:
    
    addi x2, x2, -1
    beq x2,x0,end 
    mul x3, x3, x2
    
    j repeat
end:
   addi x3, x3, 0 

# Code to exit for Spike (DONT REMOVE IT)
li t0, 1
la t1, tohost
sd t0, (t1)
# Loop forever if spike does not exit
1: j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
