.global _start 
  
.section .text 
_start:

    addi x1,x0,10
    addi x2,x0,14

    sub x3,x1,x2
    ble x3,x0, Negative # for positive number branck will not be taken
    j end
Negative:
    sub x3,x0,x3 # Negative muber will be converted to positve number
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
