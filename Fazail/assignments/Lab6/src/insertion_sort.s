.global _start

.global stack
stack:
    .space 256
stack_top:

.section .data
    array: .word 4,3,2,1,5
    array_end:

.section .text
_start:
    # Any code here
    la sp, stack_top    # point stack pointer to top of stack
    la a0, array        # point to start of array (address)
    la a1, array_end    # point to end of array + 4 (address)
#    addi a1,a1,-4       # pointing to end of array (address)
    # Calculating size of array
    sub a1,a1,a0        # t0 = ending address - starting address
    srli a1,a1,2        # t0 = t0/4 ( t0 >> 2) > since word has size of 4 bytes
                        # t0 will contain the size
    jal insertion_sort

    la a0, array
    li t0,0             # counter for test loop
    jal test_loop

    j end               # end of code

# function (arg1=*array,arg2=size)
insertion_sort:
    addi sp,sp,-8       # make 4 byte space in stack
    sw ra, 0(sp)        # save return address at sp
    sw a1, 4(sp)        # save size in sp

    addi a1,a1,-1       # since last index = size - 1
    li t0, 0            # initialize counter to 0
loop:
    addi t1,t0,0        # initializing nested loop counter to t0
    addi sp,sp,-4       # make 4 byte space in stack
    sw a0, 0(sp)        # save pointer address at sp

    lw a2, 0(a0)        # load word from pointer (current index)
    lw a3, 4(a0)        # load word from pointer + 4 byte offset (next index)

    # if 1st element > 2nd element, swap them and run nested loop towards prev elements
    blt a2,a3,loop_cont # if a2<a3, no swapping needed
    jal swap            # call swap function if a2 > a3
#    addi a0,a0,4        # increment in a0


nested_loop:
    # if condition to break loop if t1 == 0
    beq t1,zero, loop_cont
    lw a3, 0(a0)        # load word from pointer (current index)
    lw a2, -4(a0)       # load word from pointer - 4 bytes (prev index)

    bgt a3,a2,loop_cont # if a2>a3, no swapping needed

    addi a0,a0,-4       # decrement in pointer by 4 bytes (prev index)
    jal swap
    addi t1,t1,-1       # decrement in counter
    bnez t1,nested_loop # while (t1 != 0)
    # exit from loop automatic, no jump needed

loop_cont:
    addi t0,t0,1        # increment in counter

    lw a0, 0(sp)        # get back value of original pointer a0 from stack

    # make sure that address is a positive 4 byte word
    li t4,0xFFFFFFFF
    and a0,a0,t4
    addi sp,sp,4        # free 4 bytes from stack

    addi a0,a0,4        # increment in a0
    # if counter < size, keep the loop running
    blt t0, a1, loop
    # else return from function
    lw a1, 4(sp)        # return size from stack
    lw ra, 0(sp)        # return address from stack
    addi sp,sp,8        # free 8 bytes from stack
    li t4,0xFFFFFFFF
    and ra,ra,t4
    ret

#a2 = first element, a3 = 2nd element, a0 = current address
swap:
    sw a2,4(a0)         # store a2 at address of a3
    sw a3,0(a0)         # store a3 at address of a2
    ret                 # return from swap function

test_loop:
    lw t1,0(a0)         # load word from array
    addi a0,a0,4        # increment in a0 by word
    addi t0,t0,1        # increment in counter

    # while (counter t0 != a1 size)
    bne a1,t0,test_loop

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
