# LAB 5 : PROBLEM NO. 4
# REVERSE ARRAY

.global _start

.section .data

# Numbers of Array
array: .word 1, 2, 3, 4, 5
length: .word 5

.section .text

_start:

    la t0, array
    
    lw t1, length #Loads the length of array in the t1 register

    # Initialize pointers for the start and end of the array
    li t2, 0     # t2 is the start index (i)
    addi t3, t1, -1  # t3 is the end index (j)

reverse_loop:     

    blt t3, t2, end_reverse  # If j < i, end the loop

    # Calculate the addresses of array[i] and array[j]
    slli t4, t2, 2      # t4 = i * 4 (4 bytes per word)
    add t4, t4, t0      # t4 = &array[i]
    lw t5, 0(t4)        # t5 = array[i]
    
    slli t6, t3, 2      # t6 = j * 4
    add t6, t6, t0      # t6 = &array[j]
    lw s0, 0(t6)        # s0 = array[j]
    
    # Swap array[i] and array[j]
    sw s0, 0(t4)        # array[i] = s0
    sw t5, 0(t6)        # array[j] = t5
    
    # Increment i and decrement j
    addi t2, t2, 1      # i++
    addi t3, t3, -1     # j--
    
    j reverse_loop      # Repeat the loop

end_reverse:
# Signal test pass to Spike    
    li t0, 1
    la t1, tohost
    sd t0, (t1)

1: j 1b # Infinite loop  

.section .tohost 
.align 3
tohost: .dword 0
fromhost: .dword 0
