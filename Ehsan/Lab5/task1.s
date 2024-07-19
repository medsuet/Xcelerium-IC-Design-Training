.global _start
.section .text
_start:
    li t0, 67        #(Q) dividend
    li t1, 5         #(M) divisor
    li t2, 0         #(A) accumulator
    li t3, 64        #(N) no. of bits
    li t4, 0x8000000000000000  #for taking msb
    li t5, 0xfffffffffffffffe  #for making lsb zero

loop:
    beqz t3, end
    slli t2, t2, 1   #(A)
    and t6, t0, t4   #msb of Q
    srli t6, t6, 63  #making msb as lsb
    or t2, t2, t6    #set lsb of A to msb of Q
    slli t0, t0, 1   #(Q)
    sub t2, t2, t1   #A = A - M
    bltz t2, msb_is_one
    ori t0, t0, 1    #making lsb 1
    j decrement

msb_is_one:
    add t2, t2, t1   #A=A+M
    and t0, t0, t5   #making lsb 0


decrement:
    addi t3, t3, -1  #(N=N-1)decrementing counter
    j loop

end:
    # Code to exit for Spike
    li t4, 1
    la t5, tohost
    sd t4, 0(t5)
    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
