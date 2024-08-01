#  ============================================================================
#  Filename:    clearbit.s 
#  Description: File consists of code to set or clear a particular bit 
#  Author:      Bisal Saeed
#  Date:        7/15/2024
#  ============================================================================

.section .text
    .globl _start

_start:
    li   a0, 6      
    li   a1, 2      # Bit position to set or clear
    li   a2, 0       # choice to set or clear bit -> 1 = set , 0 = clear

    # check validity of position bit 
    li   t0, 31
    bltu a1, t0, valid_bit
    j    end_program

valid_bit:
    li   t1, 1  
     # store in temporary register as sll command does not operate on (a1) constant values --> should be in register    
    mv   t2, a1     
    sll t1, t1, t2   # Shift left by bit position to set the target bit to 1

    beq  a2, zero, clear_bit
    or   a0, a0, t1   # or the number with the mask t1 to set the bit 
    j    end_program

clear_bit:
    li   t1, 1   
    mv t2,a1    
    sll t1, t1, a1   
    xor  a0, a0, t1   # XOR original number with the mask t1 (as 1 xor 1 = 0) 

end_program:
    li   a7, 10       # syscall: exit
    ecall



