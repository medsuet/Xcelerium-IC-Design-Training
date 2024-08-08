.section .data
array: .word 5, 2, 4, 6, 1, 3  # Define an array of 6 elements
length: .word 6                # Length of the array

.section .text
.global _start
_start:
#Load the length of the array into a register
la a0, length    # Load address of length
lw a1, 0(a0)     # Load value of length into a1
#Initialize pointers
la a2, array     # a2 will be the base pointer to the array

#Outer loop: iterate over each element starting from the second one
li t0, 1         # t0 is the outer loop index (i)
outer_loop:
bge t0, a1, done # If i >= length, exit loop

#Load the current element to be inserted
slli t1, t0, 2   # t1 = i * 4 (byte offset for array[i])
add t2, a2, t1   # t2 = &array[i]
lw t3, 0(t2)     # t3 = array[i] (key)

#Initialize inner loop index j = i - 1
addi t4, t0, -1  # t4 = i - 1 (j)
inner_loop:
    blt t4, zero, insert  # If j < 0, exit inner loop

#Load array[j]
slli t1, t4, 2   # t1 = j * 4 (byte offset for array[j])
add t2, a2, t1   # t2 = &array[j]
lw t5, 0(t2)     # t5 = array[j]

#Compare array[j] with key
 blt t5, t3, insert  # If array[j] < key, exit inner loop

 #Shift array[j] to array[j + 1]
 sw t5, 4(t2)     # array[j + 1] = array[j]

#Decrement j
 addi t4, t4, -1  # j--
 j inner_loop     # Repeat inner loop

insert:
# Insert the key at the correct position
addi t4, t4, 1   # j++
slli t1, t4, 2   # t1 = j * 4 (byte offset for array[j])
add t2, a2, t1   # t2 = &array[j]
sw t3, 0(t2)     # array[j] = key

#Increment i (outer loop index)
addi t0, t0, 1   # i++
j outer_loop     # Repeat outer loop

done:
#Code to exit for Spike (DONT REMOVE IT)
li t0, 1
la t1, tohost
sd t0, 0(t1)

#Loop forever if Spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
