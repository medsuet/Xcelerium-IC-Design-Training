.section .data
array: .word 5, 3, 5, 7, 56, 4   # Define an array of 6 elements
length: .word 6                  # Length of the array

.section .text
.global _start

_start:
    la s0, array    # s0 = base address of array
    lw s1, length   # s1 = length of array

    li t0, 1    # t0 = i = 1
outer_loop:
    bge t0, s1, end    # If i >= length, sorting is done

    # Load the key (current element to be inserted)
    slli t1, t0, 2   #t1 = i * 4 (byte offset)
    add t2, s0, t1   #t2 = address of array[i]
    lw t3, 0(t2)     #t3 = key = array[i]

    addi t4, t0, -1  #t4 = j = i - 1

inner_loop:
    bltz t4, insert_key   #If j < 0, exit inner loop

    # Load and compare array[j] with key
    slli t1, t4, 2   #t1 = j * 4 (byte offset)
    add t2, s0, t1   #t2 = address of array[j]
    lw t5, 0(t2)     #t5 = array[j]

    ble t5, t3, insert_key  #if array[j] <= key, exit inner loop

    #shift array[j] to array[j + 1]
    sw t5, 4(t2)     #array[j + 1] = array[j]
    addi t4, t4, -1  #j--
    j inner_loop

insert_key:
    # Insert the key at the correct position
    addi t1, t4, 1    #t1 = j + 1
    slli t1, t1, 2    #t1 = (j + 1) * 4 (byte offset)
    add t2, s0, t1    #t2 = address of array[j + 1]
    sw t3, 0(t2)      #array[j + 1] = key

    addi t0, t0, 1    #i++
    j outer_loop


end:
# Code to exit for Spike
li t0, 1
la t1, tohost
sd t0, 0(t1)

# Loop forever if spike does not exit
1: j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
