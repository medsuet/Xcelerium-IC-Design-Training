.global _start
.section .text

_start:
    li a0,19
    li a1,30
    li a3,12
    li t1, 0            # Initialize count of set bitss to 0 
    li t0, 32           # Bit counter upto 32 bits
    
diff:
    # a2=a0-a1
    sub a2,a0,a1 
    bge a0,a1,done
    neg a2,a2

count_set_bits:
    andi t2, a3, 1         # Get t2=LSB
    add t1, t1, t2         # Add the t2 value to the count
    srli a3, a3, 1         # Shift right the word by 1 bit
    addi t0, t0, -1        # Decrement the bit counter by 1
    bnez t0,count_set_bits # Repeat recursively until all bits are processed

done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)
1:  j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
