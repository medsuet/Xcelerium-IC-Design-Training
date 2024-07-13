# Name: restoringdivision.s
# Author: Muhammad Tayyab
# Date: 12-7-2024
# Description: Implements restoring division algorithem for 32 bit numbers

# arguments: a2: dividend   a3: divisor
# returns:   a0: quotient   a1: reminder

.global _start

.section .text
_start:
    # Initialize registers
    li a2, 5                    # dividend
    li a3, 3                    # divisor (M)
    add a0, x0, a2              # (quotient) Q = dividend
    li a1, 0                    # (reminder) A = 0
    li t0, 32                   # (number of bits) N = 32

step2:
    # shift AQ left
    lui t3, 0x80000
    and t4, a0, t3              # get msb of Q
    srli t4, t4, 31             # shift it to lsb position
    slli a0, a0, 1              # shift Q left
    slli a1, a1, 1              # shift A left
    beq t4, x0, zeromsb         
    or a1, a1, t4               # if msb of Q is 1, set lsb of A to 1
    J step3
zeromsb:
    not t4, t4                  # bitwise not of t4
    and a1, a1, t4              # if msb of Q is 0, set lsb of A to 0

step3:
    sub a1, a1, a3              # A=A-M
    and t4, a1, t3              # get msb of A
    bne t4, x0, step4right
step4left:
    ori a0, a0, 1               # if msb of A is 0, set Q(0) = 1
    J step5
step4right:
    andi a0, a0, -2             # if msb of A is 1, set Q(0) = 0
    add a1, a1, a3              # restore A

step5:
    addi t0, t0, -1             # decrement counter
step6:
    bne t0, x0, step2           # if counter is not 0, we loop back to step2

# quotient: a0      reminder: a1  

end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
