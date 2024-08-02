.section .text
.globl _start
_start:
    # Set the stack pointer
    lui sp, 0x1
    addi sp, sp, 0x0000
    # Jump to main
    call main
    # Infinite loop to prevent exit
1:  j 1b
