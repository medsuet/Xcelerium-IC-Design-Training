.global _start

.section .data 
num: .word 7
bit_num: .word 2
set_clear: .word 0


.section .text 

_start:
    lw t0, num          # loading the number to t0 register
    lw t1, bit_num      # loading the bit number that is to be set or cleared
    lw t2, set_clear    # seting or clearing the bit , 1 means set , 0 means clear

    li t3, 1            # storing 1 in t3 for use 

    sub t4, t1, t3     # t4 = t1 - t3  (bit_num - 1)
        

    beq t2, zero, clear_bit # if t2 == zero  then clear the bit

    sll t3, t3,t1        # 1 <<  bitnum 

    or t0, t0, t3        # setting that bit 

    j end

clear_bit:
    sll t3, t3,t1        # 1 <<  bitnum 
    not t3, t3           # ~t3
    and t0, t0, t3       # clearing that bit   
    j end

end:
# Signal test pass to Spike    
    li t0, 1
    la t1, tohost
    sd t0, (t1)

1: j 1b # Infinite loop  

.section .tohost 
.align 3
tohost: .dword 0
fromhost: .dword 0





