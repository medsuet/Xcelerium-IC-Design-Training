.section .data
array: .word 5, 3, 1, 7, 2  # Define an array of 5 elements
length: .word 5             # Length of the array

.global _start
.section .text

_start:
    #initialze length
    la a0, length
    lw a1, 0(a0)

    # initialize array
    la a2, array

    # Initialize loop variables
    li t0, 1           

insertion_sort:
    blt a1, t0, done   # If i >= length - 1 - i, exit loop

    # Load the curre
    slli t1, t0, 2  
    add t2, a2, t1  
    lw t3, 0(t2)    # key = arr[ ];  

    addi t4, t3, -1   # j = i - 1;

loop:
    blt t4, zero, insert

    slli t5, t4, 2
    add  t6, t5, a2 
    lw a3, 0(t6)    #arr[j] = value

    blt a3, t3, insert  # If array[j] < key, exit inner loop

    sw a3 4(t6)     ## array[j+1] = arr[i]

    # Decrement j
    addi t4, t4, -1  # j--
    j loop     # Repeat loop
    
insert:
    addi t4, t4, 1
    slli t5, t4, 2
    add  t6, t5, a2 

    sw t3 0(t6)     ## array[j+1] = key

    # Increment i (outer loop index)
    addi t0, t0, 1   # i++
    j insertion_sort     # Repeat 



# Signal test pass to Spike
done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
