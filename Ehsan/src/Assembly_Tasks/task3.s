# .global _start
# .section .text
# _start:
#     li t0, 6         #(Q) dividend
#     li t1, 5         #(M) divisor
#     li t2, 0         #(A) accumulator
#     li t3, 64        #(N) no. of bits
#     li t4, 0x8000000000000000  #for taking msb
#     li t5, 0xfffffffffffffffe  #for making lsb zero

# loop:
#     beq zero, t3, last_check_msb_A
    
#     slli t2, t2, 1   #(A)
#     and t6, t0, t4   #msb of Q
#     srli t6, t6, 63  #making msb as lsb
#     or t2, t2, t6    #set lsb of A to msb of Q
#     slli t0, t0, 1   #(Q)

#     and t6, t2, t4 #msb of A

#     beq zero, t6, label_1  #if msb of A is 0 jump to label 1 perform A=A-M
#     add t2, t2, t1  #A=A+M
#     j label_2

# label_1:
#     sub t2, t2, t1  #A=A-M
    
# label_2:
#     beq zero, t6, label_3  #if msb of A is 0 jump to label 2, make lsb of Q one
#     and t0, t0, t5  #make lsb of Q 0
#     j decrement

# label_3:  #if msb of A is 1 make lsb of Q, 1
#     ori t0, t0, 1

# decrement:
#     addi t3, t3, -1  #(N=N-1)decrementing counter
#     j loop

# last_check_msb_A:
#     and t6, t2, t4 #msb of A
#     beq zero, t6, end  #if msb of A is 1 perform A=A+M
#     add t2, t2, t1    

# end:
#     # Code to exit for Spike
#     li t4, 1
#     la t5, tohost
#     sd t4, 0(t5)
#     # Loop forever if spike does not exit
# 1:  j 1b

# .section .tohost
# .align 3
# tohost: .dword 0
# fromhost: .dword 0

.global _start
.section .text
_start:
    li t0, 6        # (Q) dividend
    li t1, 5        # (M) divisor
    li t2, 0        # (A) accumulator
    li t3, 64       # (N) no. of bits
    li t4, 0x8000000000000000  # for taking msb
    li t5, 0xfffffffffffffffe  # for making lsb zero


loop:
    beqz t3, end    
    slli t2, t2, 1  #(A) shift a left
    and t6, t0, t4  #get msb of Q
    srli t6, t6, 63 #makes msb as lsb
    or t2, t2, t6   #set lsb of A as msb of Q
    slli t0, t0, 1  #left shift Q
    
    bgez t2, label_1  # If MSB of A is 0, label_1
    add t2, t2, t1     # A = A + M
    j label_2

label_1:
    sub t2, t2, t1     #A=A-M

label_2:
    bgez t2, label_3 # If MSB of A is 0, set Q bit
    and t0, t0, t5     # Clear LSB of Q
    j decrement

label_3:
    ori t0, t0, 1      # Set LSB of Q

decrement:
    addi t3, t3, -1    # Decrement counter
    j loop

end:
    #last check
    bgez t2, exit
    add t2, t2, t1

exit:
    # Code to exit for Spike
    li a0, 1
    la a1, tohost
    sd a0, 0(a1)
    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
