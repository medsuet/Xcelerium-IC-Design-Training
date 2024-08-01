# DATA SECTION
.section .data
    array: .word 1, 2, 3, 4, 5   # Initialze array of int
    size = 5                                     # Size of array 

# CODE SECTION
.section .text
    .globl _start

_start:
    la t0, array              
    li t1, size               
    slli t1, t1, 2            # (shift by 2 so 2^2=4) --> size*4 = total size
    add t1, t0, t1  
    li t3, 4                    
    sub t1, t1, t3           
    # Loop counter variables 
    li t2, size              
    srli t2, t2, 1            

reverse_loop:
    bge t0, t1, done
    # Swap values at t0 and t1
    lw t4, 0(t0)              # t4=t0 --> temporarily store value
    lw t5, 0(t1)              # t5=t1 --> temporarily store value
    sw t5, 0(t0)              
    sw t4, 0(t1)             
    # Change pointers position
    addi t0, t0, 4            # for starting pointer add 4 as each element is of 4 bytes
    addi t1, t1, -4           # for ending pointer substract 4 as each element is of 4 bytes
    # check loop condition
    addi t2, t2, -1           
    bnez t2, reverse_loop     # If t2 != 0, repeat the loop

done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)
1:  j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

