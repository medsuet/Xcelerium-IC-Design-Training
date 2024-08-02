# Restoring Division Algorithm

.global _start

.section .data

dividend: .dword 8
divisor: .dword  2
quotient: .dword 0
remainder: .dword 0

.section .text

_start:
    #Initializing the values
    la a0, dividend
    lw a0, 0(a0)                       # Q = dividend
    la a1, divisor
    lw a1, 0(a1)                       # M = divisor
    li a2, 0                           # Accumulator = 0
    li a3, 64                          # n = 64   
    
    li a4, 0x8000000000000000          # for taking msb
    li a5, 0xFFFFFFFFFFFFFFFe          # for making lsb zero

    li a6, 0x7FFFFFFFFFFFFFFF          # max value of int for undefined purpose

    beq a1, zero, end_zero_divisor #if divisor is 0
    beq a0, zero, end_zero_dividend #if dividend is zero 
  
division:
    beq a3, zero, end_division
    
    slli a2, a2, 1            # Accumulator << 1
    and s1, a0, a4            # msb of the Q  
    srli s1, s1, 63           # Q >> 63 to get MSB at LSB position 
    or a2, a2, s1             # Accumulator | (Q >> 63) 
    slli a0, a0, 1            # Q << 1

    sub a2, a2, a1            # Accumulator = Accumulator - M 

    blt a2,zero,msb_1         # if a2 < 0 means msb is 1
    ori a0, a0, 1             # Q(0) = 1
    addi a3, a3, -1             # N = N-1
    j division

msb_1:
    and a0, a0, a5           # Q(0) = 0
    add a2, a2, a1             #Restore A (A = A + M)
    addi a3, a3, -1             # N = N-1
    j division

end_zero_dividend:
    la x1, quotient
    sw zero, 0(x1)    # quotient = 0

    la x1, remainder
    la a0, dividend
    lw a0, 0(a0)
    sw a0, 0(x1)      # remainder = dividend

    j end

end_zero_divisor:
    la x1, quotient
    sw a6, 0(x1)    # quotient = undefined (max of int)

    la x1, remainder
    sw a6, 0(x1)      # remainder = undefined (max of int)

    j end

end_division:
    la x1, quotient
    sw a0, 0(x1)    # quotient = Q

    la x1, remainder
    sw a2, 0(x1)      # remainder = Accumulator
    j end

end:
# Signal test pass to Spike    
    li a0, 1
    la a1, tohost
    sd a0, 0(a1)

1: j 1b # Infinite loop  

.section .tohost 
.align 3
tohost: .dword 0
fromhost: .dword 0
