.global _start

.section .data 
num: .word 7
bitNum: .word 2
setClear: .word 0


.section .text 

_start:
    lw a0, num          # loading the number to a0 register
    lw a1, bitNum       # loading the bit number that is to be set or cleared
    lw a2, setClear     # seting or clearing the bit , 1 means set , 0 means clear

    li a3, 1            # storing 1 in a3 for use 

    sub t4, a1, a3     # t4 = a1 - a3  (bitNum - 1)
        

    beq a2, zero, clear_bit # if a2 == zero  then clear the bit

    sll a3, a3,a1        # 1 <<  bitnum 

    or a0, a0, a3        # setting that bit 

    j end

clear_bit:
    sll a3, a3,a1        # 1 <<  bitnum 
    not a3, a3           # ~a3
    and a0, a0, a3       # clearing that bit   
    j end

end:
# Signal test pass to Spike    
    li a0, 1
    la a1, tohost
    sd a0, (a1)

1: j 1b # Infinite loop  

.section .tohost 
.align 3
tohost: .dword 0
fromhost: .dword 0





