# Name: task3_nonrestoringdivision_c.c
# Author: Muhammad Tayyab
# Date: 16-7-2024
# Description: Implements non restoring division algorithem for unsigned 32 bit numbers

.global _start

.section .text

NonRestoringDivision:
    # Routine to divide two unsigned integers using non restoring division algorithem.
    # Arguments: a2: dividend    a3: divisor
    # Ouputs:    a0: quotient    a1: remainder
    # Returns to ra
step1:
    li t1, 32                       # Initialize loop countr to number of bits in dividend
    li a1, 0                        # Initialize remainder = 0
    li t5, 0x80000000               # Store 1 at msb position (for 32 bit number)
    mv a0, a2                       # Initialize quotient = dividend

step2:
    and t2, a1, t5                  # get msb of a1 (remainder)   
    # Shift left <remainder><quotient>
    and t3, a0, t5                  # get msb of quotient
    slli a1,a1,1                    # shift remainder left
    slli a0,a0,1                    # shift quotient left
    beq t3, x0, branch0             # if msb of quotient is 0, do nothing and jump over
    ori a1, a1, 1                   # else set lsb of remainder to 1
branch0:
    beq t2, x0, branch1             # check msb of remainder (earlier version)
    add a1, a1, a3                  # if msb of remainder is 1, remainder = remainder + divisor
    J step3
branch1:
    sub a1, a1, a3                  # if msb of remainder is 0, remainder = remainder - divisor

step3:
    and t2, a1, t5                  # get msb of a1 (remainder)
    beq t2, x0, branch2
    andi a0, a0, -2                 # if msb of remainder is 1, set lsb of quotient to 0
    J step4
branch2:
    ori a0, a0, 1                   # if msb of remainder is 1, set lsb of quotient to 1

step4:
    addi t1, t1, -1                 # decrement loop counter
    bne t1, x0, step2               # loop until counter is zero

step5:
    and t2, a1, t5                  # get msb of remainder
    beq t2, x0, return
    add a1, a1, a3                  # if msb of remainder is 1, remainder = remainder + divisor
return:
    ret


_start:
    li a2, 17                        # dividend
    li a3, 5                         # divisor
    call NonRestoringDivision
    
    # Null operation on results to show them in spike log 
    addi a0, a0, 0
    addi a1, a1, 0
    

end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
