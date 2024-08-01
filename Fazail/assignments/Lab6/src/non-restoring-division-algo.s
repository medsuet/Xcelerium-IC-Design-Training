.global _start

.global stack
stack:
    .space 256
stack_top:

.section .data
    dividend: .word 7
    divisor: .word 5
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
    addi t0,t0,1            # according to implementation example
    addi s0,t0,0            # s0 = bits --- constant register

    lw a0, 0(sp)            # revert to previous a0 i.e Q
    addi sp,sp,4            # Free 4 byte space from stack

loop:
    # step 2: Check sign bit of register A
    li t3,0x80000000
    and t3,t1,t3            # Store sign bit of A (1/0) in t3

    # step 3: manipulating AQ using sign bit

    # form combined AQ
    sll t2,t1,s0            # t2(unit_AQ) = t1(A) << s0(bits)
    or t2,t2,a0             # t2(unit_AQ) = (t2 || Q(a0))
    slli t2,t2,1            # Shift left contents of unit_AQ (both if else)

    # new value of A
    srl t1,t2,s0            # A = (unit_AQ >> bits)
    li t5,0xFFFFFFFF
    and t1,t1,t5            # A = (A & 0xFFFFFFFF)
#    li t5,0xFFFFFFFF
    and t1,t1,t5            # Keeping A as 32 bit

    # new value of Q
    addi t6,zero,32
    sub t6,t6,s0            # t6 = 32-bits
    sll a0,t2,t6            # Q = unit_AQ << t6
    and a0,a0,t5            # Q = Q & 0xFFFFFFFF
    srl a0,a0,t6            # Q = Q >> t6

    # if sign bit is 0
    beqz t3,if1            # jump to _if1
else1: # sign bit 1
    add t1,t1,a1            # A = A + M
    li t5,0xFFFFFFFF
    and t1,t1,t5            # Keeping A as 32 bit
    j cont1
if1: # sign bit 0
    sub t1,t1,a1            # A = A - M
    li t5,0xFFFFFFFF
    and t1,t1,t5            # Keeping A as 32 bit
cont1:
    # step 4: check sign bit of A
    li t3,0x80000000
    and t3,t1,t3            # Store sign bit of A (1/0) in t3

    # step 5: manipulate AQ using signed bit of A
    # if sign bit is 0
    beqz t3,if2             # jump to _if2
else2: # sign bit 1
    li t5,0xFFFFFFFE        # LSB is 0
    and a0,a0,t5            # Q[0] is set t0 0
    j cont2
if2: # sign bit 0
    li t5,0x00000001        # LSB is 1
    or a0,a0,t5             # Q[0] is set to 1
cont2:
    # step 6: decrement N
    addi t0,t0,-1

    # step 7: jump to loop if N != 0
    bnez t0,loop            # while(n != 0)

    # Exit from loop
    # step 8: if sign bit of A is 1: perform A = A+M
    li t3,0x80000000
    and t3,t1,t3            # Store sign bit of A (1/0) in t3

    beqz t3,cont3           # jump to _cont3 (skip condition)
if3: # sign bit 1
    add t1,t1,a1            # A = A + M
    li t5,0xFFFFFFFF
    and t1,t1,t5            # Keeping A as 32 bit
cont3: # sign bit 0
    # a0 = Q contains quotient, t1 = A contains remainder
    lw ra, 0(sp)            # Load ra from sp
    addi sp,sp,4            # free 4 bytes of space from stack
    li t5,0xFFFFFFFF
    and ra,ra,t5            # Keeping ra as positive 32 bit
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
