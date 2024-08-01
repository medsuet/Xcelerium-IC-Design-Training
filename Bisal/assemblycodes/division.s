#  ============================================================================
#  Filename:    divison.s 
#  Description: File consists of code for restoring division algorithm
#  Author:      Bisal Saeed
#  Date:        7/15/2024
#  ============================================================================

.section .text
.globl _start

_start:
    li a0,11    
    li a1,3     
    li a2,0     
    li t1, 0            
    li t0, 4          
count_set_bits:
    andi t2, a0, 1          
    add  t1, t1, t2         
    srli a0, a0, 1          
    addi t0, t0, -1        
    bnez t0,count_set_bits 
division:
    beqz t1, done
    srl a3,a0,t1
    andi a3,a3,1        
    sll a0, a0, 1       
    sll a2,a2,1       
    or a2, a2, x4        
    addi t3,a2,0            
    sub a2,a2,a1       
    srl a4,a0,t1
    andi a4,a4,1   
    li a5,1
    beq a4, a5, restore
    ori a0, a0, 1      
    addi t1, t1, -1    
    j division
restore:
    andi a0, a0, -2          
    addi a2,t3,0              
    addi t1, t1, -1
    j division 
          
done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)
1:  j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

