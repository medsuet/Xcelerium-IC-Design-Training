#make start a global label
.global _start

#show that code section is written below
.section .text
#indicates start of program

_start:
    #load values
    li a0,19
    li a1,30

    #for bitcount
    li a3,12
    #temporary registers
    li t1, 0            # Initialize count of set bitss to 0 
    li t0, 32           # Bit counter upto 32 bits
    

#calculate difference between two numbers 
diff:
    #a0-a1=a2
    sub a2,a0,a1 
    #check if x2 is smaller than x3 for absolute difference -->branch to done
    bge a0,a1,done
    #convert negative value of a2 to positive value
    neg a2,a2

count_set_bits:
    andi t2, a3, 1      # Get t2=LSB
    add t1, t1, t2      # Add the t2 value to the count
    srli a3, a3, 1      # Shift right the word by 1 bit
    addi t0, t0, -1       # Decrement the bit counter by 1
    bnez t0,count_set_bits # Repeat recursively until all bits are processed

#NOTE: Need code below to indicate spike that program has ended
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

