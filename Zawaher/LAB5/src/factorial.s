.global _start 

.section .data 
num: .word 7 #number whose factorial is to be calculated

factorial: .word 0

.section .text

_start:


    addi x1,x0,1
    la x2,num #loads the adress of the num which factorial is calculated
    lw x3,0(x2)
    addi x5,x0,1

fac:
    beq x3,x1,end
    mul x5,x5,x3
    sub x3,x3,x1
    j fac  # jump to fac
    

end:


    la x6, factorial
    sw x5,0(x6)   #stores the factorial to memory
#Signal test pass to Spike    
    li t0, 1
    la t1, tohost
    sd t0, (t1)


1: j 1b # Infinite loop  



.section .tohost

.align 3

tohost: .dword 0

fromhost: .dword 0












