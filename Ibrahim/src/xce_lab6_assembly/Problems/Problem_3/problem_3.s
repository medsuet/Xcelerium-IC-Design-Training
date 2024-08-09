.section .data
    number:     .word 5     # Number whose factorial we want to calculate
    result:     .word 0     # To store the factorial result


.section .text
.globl _start

_start:
    la t0, number   # Load the number into a register
    lw t1, 0(t0)    # t1 = number

    li t2, 1        # Initialize result to 1     

factorial_loop:
    # Check if the number is zero
    beqz t1, end_factorial  # if (number == 0) jump to end_factorial

    mul t2, t2, t1          # Multiply result by the number

    addi t1, t1, -1         # Decrement the number

    j factorial_loop        # Loop back to factorial_loop

end_factorial:
    # Store the result
    la t0, result       # Result is stored in register t2
    sw t2, 0(t0)

# Code to exit for Spike (DONT REMOVE IT)
 li t0, 1
 la t1, tohost
 sd t0, (t1)
 # Loop forever if spike does not exit
1: j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
