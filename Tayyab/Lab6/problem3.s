# Name: problem3.s
# Author: Muhammad Tayyab
# Date: 12-7-2024
# Description: Calculate factorial recursively

.global _start

# Define a stack with total size of 160 bytes (40 words).
# stackframe size is 2 words (each function call to factoral has its own stackframe)
# 2 registers can be saved in each stackframe. At max 20 stackframes can be pushed.
# For n!, n stackframes are required.
.section .data
stack: .word
.space 160

.section .data
framesize: .word 2

.section .text
push_to_stack:
    # Routine to push registers to stack and update sp to new stackframe
    # Registers saved: a1, ra
    sw a1, 0(sp)                    # store a1 (current value of n) on stack
    sw ra, 4(sp)                    # store ra (return address from current function) on stack

    # Increment sp
    la t1, framesize                # load address of framesize
    lw t1, 0(t1)                    # load value of framesize (in words)
    slli t1, t1, 2                  # multiply framesize by 4 to get framesize in bytes
    add sp, sp, t1                  # increment sp by framesize so that it now points to start of new frame
    jalr x0, t0                     # return

pull_from_stack:
    # Routine to pull registers from stack and update sp to previous stackframe
    # Decrement sp
    la t1, framesize                # load address of framesize
    lw t1, 0(t1)                    # load value of framesize (in words)
    slli t1, t1, 2                  # multiply framesize by 4 to get framesize in bytes
    sub sp, sp, t1                  # decrement sp by framesize so that it now points to start of previous frame

    # Registers loaded: a1, ra
    lw a1, 0(sp)                    # load a1 (value of n in current function) from stack
    lw ra, 4(sp)                    # load ra (return address from current function) from stack
    li t1, 0xFFFFFFFF
    and a1, a1, t1                  # mask a1 and ra to keep only lower 32 bits (1 word)
    and ra, ra, t1                  # as this code uses 32 bit register size, while underlying architecture is 64 bit

    jalr x0, t0                     # return

multiply:
    # Multiplies two integers
    # Arguments: a6, a7: operands
    # Output: a0: product: a6 * a7
    li a0, 0
loop:
    # Add operand1 and decrement operand2 until operand2 is zero
    add a0, a0, a6
    addi a7, a7, -1
    bgt a7, x0, loop
    jalr x0, t0

factorial:
    # Calculates factorial of a number recursively
    # Arguments: a1: number to calculate factorial of
    # Outputs: a0: factorial of the number

    beq a1, x0, basecase            # if the number is zero, go to basecase
                                    # else fact(n) = n * fact(n-1)
    jal t0, push_to_stack           # push ra (return address) and a1 (n) to stack
    addi a1, a1, -1                 # compute a1=n-1
    jal ra, factorial               # call fact(n-1)
    jal t0, pull_from_stack         # pull ra (return address) and a1 (n) from stack
    
    mv a6, a0                       # store result of fact(n-1) in a6
    mv a7, a1                       # store n in a7
    jal t0, multiply                # call multiply routine to do n*fact(n-1)
    ret                             # return to previous recursive calling of function or to main
basecase:
    li a0, 1                        # if number is zero, its factorial is 1
    ret                             # return to previous recursive calling of function or to main

_start:
    la sp, stack                    # initialize stack pointer to top of stack
    li a1, 20                       # number to calculate factorial
    jal factorial                   # call fact(a1)

# spike run: until pc 0 800000a4 and check reg 0 a0 for answer
end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
