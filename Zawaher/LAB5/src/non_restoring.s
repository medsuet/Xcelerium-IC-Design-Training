.global _start

.section .data

dividend: .dword 2
divisor: .dword 0
quotient: .dword 0
remainder: .dword 0

.section .text

_start:
    la t0, dividend
    lw t0, 0(t0)     # Q = dividend
    la t1, divisor   
    lw t1, 0(t1)     # M = divisor
    li t2, 0         # Accumulator = 0
    li t3, 64       # Count = 64 

    li t4, 0x8000000000000000  #for taking msb
    li t5, 0xFFFFFFFFFFFFFFFe  #for making lsb zero

    li t6, 0x7FFFFFFFFFFFFFFF # max value of int for undefined purpose

    beqz t0, end_zero_dividend    # if the  dividend is zero
    beqz t1, end_zero_divisor     # if the divisor is zero
division:

    beqz t3, last_accum_check 

    blt t2, zero, neg_accum     #if the value of accumulator is negative

    # else condition

    slli t2, t2, 1              # Accumulator << 1
    and  s1, t0, t4             # s1 = Q & 0x80000000000
    srli s1, s1, 63             # s1 >> 63  to get MSB at LSB
    or t2, t2, s1               # Accumulator = Accumulator | (Q >> 63)
    slli t0, t0, 1              # Q << 1
    sub t2, t2, t1             # Accumulator = Accumulator  - M
    j second_accum_check


    

neg_accum:

    slli t2, t2, 1              # Accumulator << 1
    and  s1, t0, t4             # s1 = Q & 0x80000000000
    srli s1, s1, 63             # s1 >> 63  to get MSB at LSB
    or t2, t2, s1               # Accumulator = Accumulator | (Q >> 63)
    slli t0, t0, 1              # Q << 1
    add t2, t2, t1             # Accumulator = Accumulator  + M
    j second_accum_check

second_accum_check:

    blt t2, zero, Q_lsb         # Check if the Accuumulator is negative
    ori t0, t0, 1               #Q(0) = 1 
    addi t3, t3, -1             #  N = N - 1
    j  division                 # jump to  division
    
Q_lsb:
    and t0, t0, t5             # Q(0) = 0
    addi t3, t3, -1             #  N = N - 1
    j division


last_accum_check:
    bge t2, zero ,end_division  
    add t2, t2, t1               # Acc = Acc + M
    j end_division

end_zero_dividend:
    la x1, quotient
    sw zero, 0(x1)    # quotient = 0

    la x1, remainder
    la t0, dividend
    lw t0, 0(t0)
    sw t0, 0(x1)      # remainder = dividend

    j end

end_zero_divisor:

    la x1, quotient
    sw t6, 0(x1)    # quotient = undefined (max of int)

    la x1, remainder
    sw t6, 0(x1)      # remainder = undefined (max of int)

    j end

end_division:
    la x1, quotient
    sw t0, 0(x1)    # quotient = Q

    la x1, remainder
    sw t2, 0(x1)      # remainder = Accumulator
    j end

end:
# Signal test pass to Spike    
    li t0, 1
    la t1, tohost
    sd t0, 0(t1)

1: j 1b # Infinite loop  

.section .tohost 
.align 3
tohost: .dword 0
fromhost: .dword 0





