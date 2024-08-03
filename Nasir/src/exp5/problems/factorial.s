.global _start

# data section
.section .data
    number: .word 0 # number to find its factorial
    factorial: .word # variable to store factorial of a number
#code section
.section .text

_start:
    la t0, number         # auipc t0,0(t0) = pc -> addi , t0, t0, offset on which number stored in memory
    lw t1, 0(t0)           # load number into t1
    addi t2,t1,0             # load number into t2
    li t5,1               # t5 = 1
    li t6,1               # t6 = 1
    sub t3, t2, t5         # t3 = t2 -1
    # sub t4, t2, t5         # t3 = t2 -1
    la t0, factorial     # load address of factorial in t0
    # handling 0 and 1 
    beqz t1, _zero
    beq t1, t6, end   # handling factorial of 1
greater:
        bnez t3, loop # OR bne t3, t6, loop
# baseCase:  
#     beq t3, t5, end
_zero:
    addi t1,t1,1
    beqz t2, end
# inductiveStep:
#     add t1,t1,t2
#     addi t5,t5,1
#     sub t3,t3,t6 
#     bne t5,t4, baseCase

loop:
    add t1,t1,t2
    addi t5,t5,1
    bne t5,t3, loop
    li t5,1 
    addi t2,t1,0 
    sub t3,t3,t6 
    bne t3,t6, greater

end:
    sw t1, 0(t0) # store value of factorial in memory
    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, (t1)
    # Loop forever if spike does not exit
1:  j 1b


.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
