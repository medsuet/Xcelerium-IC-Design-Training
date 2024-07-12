.global _start

.section .data
    number: .word 5  # number from which I want to extract set bits or no of one's
    numberOfSetBits: .word 0 # no. of setbits or one's initially
.section .text

_start:
    la t0, number # store address in x5 =t0
    lw t1, (t0)   # load value of number in x6=t1
    la t0, numberOfSetBits
    lw t2, (t0)   # load value of number in x7 = t2
    li t3, 32     # counter end
    li t4, 0      # counter
    li t5,0       # 1 bit
    li t6,1       # t6 = x11 = 1

loop:
    and t5,t1,1   # checking number bit is one or zero
    beq t5, t6, countBits; # if t0 == t1 then target
    srli t1,t1,1  # right shift by one to get number's next bit
    addi t4,t4,1  # increment counter
    blt t4, t3, loop # loop

countBits:
    addi t2,t2,1  # increment by 1
    srli t1,t1,1  # right shift by one to get number's next bit
    addi t4,t4,1  # increment counter
    blt t4, t3, loop # loop

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
