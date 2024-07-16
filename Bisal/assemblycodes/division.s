#  ============================================================================
#  Filename:    divison.s 
#  Description: File consists of code for restoring division algorithm
#  Author:      Bisal Saeed
#  Date:        7/15/2024
#  ============================================================================

.section .text
.globl _start

_start:

    # intialize the registers
    li a0,11    # value of Q=divident
    li a1,3     # value of M=divisor
    li a2,0     # value of A initialized with 0
    # temporary registers
    li t1, 0            # Initialize count of set bitss to 0 
    li t0, 4            # Bit counter upto 4 bits

count_set_bits:
    # count number of bits for dividend --> n= bit length
    andi t2, a0, 1          # LSB of Q 
    add  t1, t1, t2         # Add the t2 value to the count
    srli a0, a0, 1          # Shift right the word by 1 bit
    addi t0, t0, -1         # Decrement the bit counter by 1
    bnez t0,count_set_bits  # Repeat recursively until all bits are processed

division:
    beqz t1, done
    # SHIFTING
    srl a3,a0,t1
    andi a3,a3,1        # msb of Q
   # sll a2, a2, 1          
   # srl x5, a0, 4          
    sll a0, a0, 1       # Shift Q left by 1  
    sll a2,a2,1         # shift A
    or a2, a2, x4       # msb of Q becomes lsb of A 

    # ADDITION (A - M)
    addi t3,a2,0            # temporarily store A for restore purposes 
    sub a2,a2,a1        # A <- A-M

    # intialize msb of A 
    srl a4,a0,t1
    andi a4,a4,1     # msb of A
    
    # check conditions on msb of A
    li a5,1
    beq a4, a5, restore

    ori a0, a0, 1      # store lsb of Q as 1
    addi t1, t1, -1    # Decrement value of count (t1)

    j division

restore:
    andi a0, a0, -2           # store lsb of Q as 0 
    addi a2,t3,0              # restore the value of A 
    addi t1, t1, -1
    j division 

   
          
# NOTE: Need code below to indicate spike that program has ended
done:
    # Signal end of program (for Spike simulator)
    li t0, 1
    la t1, tohost
    sd t0, (t1)

    # Loop forever to stop the program from continuing
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

