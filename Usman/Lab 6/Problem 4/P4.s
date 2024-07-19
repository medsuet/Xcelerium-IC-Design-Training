.section .data
array: 
    .word 1, 2, 3, 4, 5  # Example array of integers
    array_size: .word 5  # Size of the array

.section .text
.global _start

_start:
    


    # Load the size of the array into x2
    la x2, array_size
    lw x1, 0(x2)

    # Calculate the number of swaps needed (array_size / 2)
    srai x3, x1, 1/2  # x3 = x1 / 2

    # Set up pointers for the start and end of the array
    la x4, array        # x4 points to the start of the array
    addi x5, x4, 4  # t5 points to the second element (start + 1 element)
    la x6, array        # x6 points to the start of the array
    slli x7, x1, 2      # x7 = array_size * 4 (each word is 4 bytes)
    add x6, x6, x7      # x6 now points to the end of the array
    addi x6, x6, -4     # x6 points to the last element (end - 1 element)

reverse_loop:
    beqz x3, done           # If x3 (number of swaps) is zero, exit loop

    # Load elements from the start and end of the array
    lw x8, 0(x4)            # Load element from the start into x8
    lw x9, 0(x6)            # Load element from the end into x9

    # Swap the elements
    sw x9, 0(x4)            # Store the end element at the start
    sw x8, 0(x6)            # Store the start element at the end

    # Move the pointers
    addi x4, x4, 4          # Move start pointer to the next element
    addi x6, x6, -4         # Move end pointer to the previous element

    # Decrement the number of swaps
    addi x3, x3, -1
    j reverse_loop          # Repeat the loop

done:
     # Code to exit for Spike (DONT REMOVE IT)
     li t0, 1
     la t1, tohost
     sd t0, 0(x1)
     # Loop forever if Spike does not exit
     1:  j 1b

.section .bss
.align 3
tohost: .dword 0
fromhost: .dword 0

