.global _start

.global stack
stack:
    .space 4096
stack_top:

.section .text
.globl _start
factorial:
    addi sp,sp,-8           # Making space for num & ra in stack
    sw ra, 4(sp)            # ra is first element in stack
    sw a0, 0(sp)            # num is second element in stack

    # if (n>2), recursively call factorial(n-1)
    slti t0,a0,2            # set t0 to 1 if num(a0) < 2 - set less than immediate
    beqz t0, recurse        # call recurse if t0 is 0 - means num(a0) > 2

    # otherwise return 1
    li a0,1
    addi sp,sp,8            # free 2 words from stack
    ret                     # jump to return address 'ra'

# factorial(n-1)
recurse:
    addi a0,a0,-1            # n = n-1, decrement a0
    jal factorial           # factorial(n-1), jal automatically updates 'ra'

    # after returning from factorial(n-1)
    mv t0,a0                # move result of fact(n-1) to t0, freeing a0
    lw a0,0(sp)             # restoring initial a0 value (prev n)
    lw ra,4(sp)             # restoring initial return address (ra)
    addi sp,sp,8            # free 2 words from stack
    li t1, 0xFFFFFFFF
    and ra,ra,t1            # if ra is negative, make it positive

    #n*fact(n-1)
    mul a0,a0,t0            # a0 = a0*t0 (n = n*fact(n-1))
    ret                     # return to ra



_start:
    # Main
    la sp, stack_top        # Point stack pointer to the top of stack
    li a0, 6                # Initializing a number as argument

    jal factorial           # Execute factorial(n) function, updates 'ra' to this address
                            # 'ret' instruction will return to (pc + ra)

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
