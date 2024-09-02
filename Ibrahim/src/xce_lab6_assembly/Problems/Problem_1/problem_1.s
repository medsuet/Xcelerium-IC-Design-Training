.section .data
num1:       .word -10             # First number (example value: 10)
num2:       .word 3               # Second number (example value: 3)
diff:       .word 0               # Placeholder for the difference

.section .text
.globl _start

_start:
    # Load predefined numbers into registers
    la t0, num1
    lw t1, 0(t0)           # Load num1 into t1
    la t0, num2
    lw t2, 0(t0)           # Load num2 into t2

    # Calculate the difference t1 - t2
    sub t3, t1, t2

    # Calculate the absolute value
    bgez t3, store_result  # If t3 >= 0, skip to store_result
    neg t3, t3             # Negate t3 to make it positive

store_result:
    # Store the result
    la t0, diff
    sw t3, 0(t0)           # Store the result in diff
    lw t4, 0(t0)           # load the result in t4

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
