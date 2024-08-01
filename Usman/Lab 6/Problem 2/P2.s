.global _start
.section .text
_start:
li x1, 9  # number of set bits
li x2, 1  # number to iterate
li x6, 0   #store result

li x4, 0 #  counter
li x5, 5
li x0, 0
loop:
   
      
   
   and x6, x1, x2
   
   beq x2, x5, end 
   
   bne x6, x0, append
  
   add x2, x2, 1
   j loop
append:
     add x4, x4, 1
     add x2, x2, 1
     j loop

end:
  addi x4, x4, 0

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
