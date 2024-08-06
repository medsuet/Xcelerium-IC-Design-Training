.global _start

.section .data

num: .word 56   #number whose set bit are to be counted
count: .word 0  

.section .text

_start:


addi x1,x0,0  #counter
addi x2,x0,1  # 1 to be shifted 
addi x7,x0,0  #num of set bits
addi x8,x0,31
la x3, num    #loads the address of num variable in x3  
lw x4, 0(x3) 



Loop:
    beq x1,x8,end  # if x1 =31 end
    sll x5,x2,x1    #shifts the 1 by number stored in x1
    and x6,x4,x5
    addi x1,x1,1    #increments the counter
    beq x6,x5,num_set_bits  #check if the bit is 1 or not 
    j Loop

num_set_bits:
    addi x7,x7,1
    j Loop

end: 
    la t0,count
    sw x7,0(t0)

#Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)


1: j 1b # Infinite loop  


.section .tohost

.align 3

tohost: .dword 0

fromhost: .dword 0

