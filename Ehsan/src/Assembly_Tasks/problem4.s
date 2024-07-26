#reversing array
.data
array: .word 1, 2, 3, 4, 5
size: .word 5
.text
.global _start

_start:
    la t0, array     #load address of array in t0
    lw t1, size      #load size of array
    addi t1, t1, -1  #subtract 1 from size
    slli t1, t1, 2   #multiply by 4 because every number is 4 bytes
    add t2, t0, t1   #address of last index stored in t2

loop:
    bge t0, t2, end  
    lw t5, 0(t0)     #load element from start
    lw t6, 0(t2)     #load element from end
    sw t6, 0(t0)     #store end element at start
    sw t5, 0(t2)     #store start element at end
    addi t0, t0, 4   #incrementing start pointer
    addi t2, t2, -4  #decrementing end pointer
    j loop

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
