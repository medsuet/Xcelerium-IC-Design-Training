#programe to find absolute difference between two numbers;
.global _start
.section .text

array:  .word 25, 4, 4, 10, 5  # Example array
_start:
la   x5, array               # Load address of the array
addi   x6, x0, 5                # Load size of the array into x6
addi x7, x0, 1               # Initialize i = 1
outer_loop:
    bge  x7, x6, end_outer       # If i >= size, exit
    lw   x8, 0(x5)               # Load array[i] into x8
    addi x9, x7, -1              # j = i - 1
inner_loop:
    bgez x9, check               # If j < 0, check position
    lw   x10, 0(x5)              # Load array[j] into x10
    blt  x10, x8, check          # If array[j] < array[i], go to check
    sw   x10, 4(x5)              # array[j+1] = array[j]
    addi x5, x5, -4              # Move to the previous element
    addi x9, x9, -1              # j--
    j    inner_loop              # Repeat inner loop
check:
    sw   x8, 0(x5)               # Insert array[i] into its position
    addi x5, x5, 4               # Move to the next element
    addi x7, x7, 1               # i++
    j    outer_loop              # Repeat outer loop
end_outer:
    j exit
exit:
li t0, 1
la t1, tohost
sd t0, (t1)

# Loop forever if spike does not exit
1: j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
