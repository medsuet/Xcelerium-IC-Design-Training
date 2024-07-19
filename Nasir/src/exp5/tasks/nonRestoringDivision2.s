.global _start

.section .data
    dividend: .word 1 # dividend
    divisor: .word 20 
    remainder: .word 0
    quotient: .word 0
# Code Section
.section .text

_start:
    la t0, dividend     # load address of dividend in t0
    lw t1, (t0)         # load value of dividend in t1
    la t0, divisor      # load address of divisor in t0
    lw t2, (t0)         # load value divisor in t2
    beqz t2, end
    la t0, remainder    # load address of remainder in t0
    lw t3, (t0)         # load value of remainder in t3
    la t0, quotient     # load address of quotient in t0
    lw t4, (t0)         # load value of quotient in t4
    li t5, 0x80000000            # load 1 in t5
    li x10, 32   
    li x11, 0x80000000 
    li x13, 0

loop:
    # slli t5,t5, 31   # 1 << 31
    and t6, t3, t5   # t6 = t3  & t5 = remainder MSB
    and x12, t1, t5  # x12 = t1 & t5 = 0x800000000 0r 0x0 depending upon sign bit of dividend
    srli x12, x12, 31 # extract sign bit
    # shift and update remainder
    slli t3, t3, 1   # shift remainder by 1
    or t3, t3, x12; # t3 = t3 | x12  
    # shift and update dividend
    slli t1, t1,1  # shift dividend by 1
    beq t6, x11, addition # if t6 == x11=1 then addition
    beqz t6, subtraction  # if t6 == 0 then subtraction

addition:
    add t3, t3, t2
    j sign

subtraction:
    sub t3, t3, t2
    j sign

sign:
    # extract sign bit of remainder
    and t6, t3, t5
    beq t6, x11, quotientLsbZero # if t6 == x11 = 1 then quotientLsbZero
    beqz t6, quotientLsbOne      # if t6 == 0 then quotientLsbOne

quotientLsbZero:
    slli t4, t4,1
    j updateLoopCounter
    
quotientLsbOne:   
    slli t4, t4, 1
    or t4, t4, 1
    j updateLoopCounter   

updateLoopCounter:
    # update loop counter 
    addi x13,x13,1
    blt x13, x10, loop       # if x13 < x10 = 32 continue in loop
    # extract sign bit of remainder
    and t6, t3, t5
    beq t6, x11, lastAddition
    beqz t6, end

lastAddition:
    add t3, t3, t2

end:
    la t0, remainder
    sw t3, 0(t0)
    la t0, quotient
    sw t4, 0(t0)
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


    
