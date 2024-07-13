# Name: problem3.s
# Author: Muhammad Tayyab
# Date: 11-7-2024
# Description: Calculate factorial recursively

.global _start

# Define a stack with total size of 160 bytes (40 words).
# Substack size is 2 words (each function call to factoral has its own substack)
# 2 registers can be saved in each substack. At max 20 stacks can be pushed.
.section .data
stack: .word
.space 160

.section .data
stacksize: .word 2

.section .text
push_to_stack:
    # Routine to push registers to stack and update sp to new substack
    # Registers saved: a1, ra
    sw a1, 0(sp)
    sw ra, 4(sp)

    # Increment sp
    la t1, stacksize
    lw t1, 0(t1)
    slli t1, t1, 2
    add sp, sp, t1
    jalr x0, t0

pull_from_stack:
    # Routine to pull registers from stack and update sp to previous substack
    # Decrement sp
    la t1, stacksize
    lw t1, 0(t1)
    slli t1, t1, 2
    sub sp, sp, t1

    # Registers loaded: a1, ra
    lw a1, 0(sp)
    lw ra, 4(sp)

    jalr x0, t0

multiply:
    # Multiplies two integers
    # Arguments: a6, a7: operands
    # Output: a5: product: a6 * a7
    li a5, 0
loop:
    # Add operand1 and decrement operand2 until operand2 is zero
    add a5, a5, a6
    addi a7, a7, -1
    bgt a7, x0, loop
    jalr x0, t0

factorial:
    # Calculates factorial of a number recursively
    # Arguments: a1: number to calculate factorial of
    # Outputs: a0: factorial of the number

    beq a1, x0, basecase            # if the number is zero, go to basecase
                                    # else f(n) = n * f(n-1)
    jal t0, push_to_stack
    addi a1, a1, -1
    jal ra, factorial
    jal t0, pull_from_stack
    
    mv a6, a0
    mv a7, a1
    jal t0, multiply
    mv a0, a5
    ret
basecase:
    li a0, 1                        # if number is zero, its factorial is 1
    ret

_start:
    la sp, stack
    li a1, 3
    jal factorial

end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
