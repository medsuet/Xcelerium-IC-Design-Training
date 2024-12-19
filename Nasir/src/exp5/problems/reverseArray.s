# Steps
# load addresses of first and last element
# load data 
# swap and store in memory
# update addresses
# update indexes from start and last
# loop or repeat until starting index less than last index

.global _start

# data section
.section .data
    array: .word 1, 2, 3, 4, 5, 6, 7 # array
    size: .word 28              # size of array in bytes for integers

# code section
_start:
    la t0, array  # load first element of array address
    la t5, size   # t5 = address of size
    lw t6, 0(t5)  # t6 = size data
    li t4, 4      # t4 = 4
    sub t6, t6,t4 # t6 = t6 - 4
    add t1,t0,t6 # load last element of array address in t1
    li t5, 4      # t5 = 4

loop:
    lw t2, 0(t0) # load 1st element in t2
    lw t3, 0(t1) # load last element in t3
    sw t2, 0(t1) # store 1st element to last location
    sw t3, 0(t0) # store last element to first
    # update addresses
    addi t0, t0,4
    sub t1, t1,t4
    # update starting and end sizes for repeated loop
    addi t5,t5,4  # t5 = t5 + 4
    sub t6,t6, t4 # t6 = t6 - 4

    blt  t5, t6, loop # if t5 < t6 repeat else end

end:

# Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, (t1)
    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0



