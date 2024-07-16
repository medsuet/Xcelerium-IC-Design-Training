# DATA SECTION
.section .data
    array: .word 1, 2, 3, 4, 5   # Initialze array of int
    size = 5                                     # Size of array 

# CODE SECTION
.section .text
    .globl _start

_start:
    # Load the base address of the array into t0
    la t0, array              
    
    # Calculate the end address of the array into t1
    li t1, size               
    slli t1, t1, 2            # (shift by 2 so 2^2=4) --> size*4 = total size
    add t1, t0, t1  
    li t3, 4                    
    sub t1, t1, t3             # point at last element of array
 
    # Loop counter variables 
    li t2, size              
    srli t2, t2, 1            

reverse_loop:
    # Compare start >= end, break the loop
    bge t0, t1, end_reverse

    # Swap values at t0 and t1
    lw t4, 0(t0)              # t4=t0 --> temporarily store value
    lw t5, 0(t1)              # t5=t1 --> temporarily store value
    sw t5, 0(t0)              # Store value of t5 in t0 to replace current value with t1
    sw t4, 0(t1)              # Store value of t4 in t1 to replace current value with t0S

    # Change pointers position
    addi t0, t0, 4            # for starting pointer add 4 as each element is of 4 bytes
    addi t1, t1, -4           # for ending pointer substract 4 as each element is of 4 bytes

    # check loop condition
    addi t2, t2, -1           
    bnez t2, reverse_loop     # If t2 != 0, repeat the loop

end_reverse:
    li a7, 10                 # syscall: exit
    ecall

