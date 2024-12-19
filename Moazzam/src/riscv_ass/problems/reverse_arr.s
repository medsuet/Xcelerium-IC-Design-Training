.section .data
array: .word 1, 2, 3, 4, 5  # Define an array of 5 elements
length: .word 5             # Length of the array

.global _start
.section .text

_start:
    #initialze length
    la t0, length
    lw t1, 0(t0)

    # initialize array
    la t2, array
    addi t3, t2, 16;    #end address of array

    # Initialize loop variables
    li t5, 0           # t5 is the loop index (i)
    addi t6, t1, -1    # t6 = length - 1 (used for comparison)

reverse_loop:
    bge t5, t6, done   # If i >= length - 1 - i, exit loop

    # Load elements to swap
    lw s1, 0(t2)       # Load array[i] into s1
    lw s2, 0(t3)       # Load array[length-1-i] into s2

    # Swap elements
    sw s1, 0(t3)       # Store array[i] at array[length-1-i]
    sw s2, 0(t2)       # Store array[length-1-i] at array[i]

    # Update pointers
    addi t2, t2, 4     # Increment start pointer (i++)
    addi t3, t3, -4    # Decrement end pointer (length-1-i--)

    # Update loop index
    addi t5, t5, 1     # i++

    j reverse_loop     # Repeat the loop



# Signal test pass to Spike
done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
