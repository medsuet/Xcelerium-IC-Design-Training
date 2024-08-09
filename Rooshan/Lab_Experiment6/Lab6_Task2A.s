.global _start 
.section .text

_start:
    addi x2,x0,5 # VALUE
    addi x3,x0,3  # Bit number
    addi x4,x0,1  # Set(1) or Clear(0)
    addi x5,x0,1  # x5 will be used to set the required bit
    sll x5,x5,x3
    xori x6,x5,-1  # Mask(x5) for clearing the required bit
    beq x4,x0,Clear

Set:
    or x2,x2,x5
Clear:
    and x2,x2,x6

end:
    add x0, x0, x0
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
