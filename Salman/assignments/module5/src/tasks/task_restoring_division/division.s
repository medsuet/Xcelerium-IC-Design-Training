.global _start

.global stack
stack:
    .space 256
stack_top:

.section .data
    dividend: .word 11
    divisor: .word 3
    quotient: .word 0
    remainder: .word 0

.section .text
.globl _start

_start:
    # Main
    la sp, stack_top        # Point stack pointer to the top of stack
    la a0, dividend         # Load address for dividend
    la a1, divisor          # Load address for divisor
    la a2, quotient         # Load address for quotient
    la a3, remainder        # Load address for remainder

    lw a0, 0(a0)            # Load value of dividend in a0 = Q
    lw a1, 0(a1)            # Load value of divisor in a1 = M

    jal restoring_division  # jump to function

    j end

# function( Q=a0,M=a1,&quotient=a2,&remainder=a3)
restoring_division:

    # step-1: initializing
    addi t1,zero,0          # t1 = A, initializing to 0

    addi sp,sp,-8           # Make 8 byte space in stack
    sw ra, 4(sp)            # backup return address in stack
    sw a0, 0(sp)            # backup dividend in stack - since a0 will be an argument to bit_counter function

    jal bit_counter         # bitcounter to count bits of dividend - t0 = n
    addi s0,t0,0            # s0 = bits --- constant register

    lw a0, 0(sp)            # revert to previous a0 i.e Q
    addi sp,sp,4            # Free 4 byte space from stack

loop:
    # step 2: shifting A and Q as single unit
    # unit_AQ = ( (A << bits) | Q )
    sll t2,t1,s0            # t2(unit_AQ) = t1(A) << s0(bits)
    or t2,t2,a0             # t2(unit_AQ) = (t2 || Q(a0)#)
    slli t2,t2,1            # t2(unit_AQ) = t2(unit_AQ) << 1

    # new value of A
    srl t1, t2, s0          # A = (unit_AQ >> bits)
    li t5,0xFFFFFFFF
    and t1,t1,t5            # A = (A & 0xFFFFFFFF)

    # new value of Q
    li t6,32
    sub t6,t6,s0            # t6 = 32 - bits
    sll a0,t2,t6            # Q = unit_AQ << t6
    and a0,a0,t5            # Q = Q & 0xFFFFFFFF
    srl a0,a0,t6            # Q = Q >> t6

    # step 3: subtract constant M from A, keep track of prev_A
    addi t2,t1,0            # Making copy - prev_A in t2
    sub t1,t1,a1            # A = A - M

    # step 4: check the MSB of A
    li t5,0x80000000        # MSB is 1
    and t3,t1,t5            # t3 = MSB of A, either 1 or 0

    # if msb is 0
    beqz t3,msb_zero        # jump to msb_zero if msb is zero
    # if msb is 1
    li t5,0xFFFFFFFE        # LSB is 0
    and a0,a0,t5            # LSB of Q set to 0
    addi t1,t2,0            # A = prev_A
    j cont
msb_zero:
    # if msb is 0 - LSB of Q is set to 1
    li t5,0x00000001
    or a0,a0,t5             # LSB set to 1 - Q = Q || 0x00000001
cont:
    # step 5: decrement counter n
    addi t0,t0,-1

    # step 6: run loop till n>0
    bnez t0,loop

    # exiting from loop
    # Q has quotient, A has remainder
    lw ra, 0(sp)            # Load ra from sp
    addi sp,sp,4            # free 4 byte space from stack
    li t5, 0xFFFFFFFF
    and ra,ra,t5            # Keeping ra as positive
    ret                     # Return from function


# function(n=a0) - Implement function to count number of bits
bit_counter:
    addi t0,zero,0          # initializing counter to 0
_loop1:
    srli a0,a0,1            # num = num/2
    addi t0,t0,1            # increment in count

    bnez a0, _loop1         # while (num)

    ret                     # answer in t1

end:
    # Code to exit from SPIKE
    li t0,1
    la t1,tohost
    sd t0, (t1)


# Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
