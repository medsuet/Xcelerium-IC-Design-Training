.global _start

.section .data
    array: .word 1,2,3,4,5
    array_end:

.section .text
_start:
    # Any code here
    la a0, array        # point to start of array (address)
    la a1, array_end    # point to end of array + 4 (address)
#    addi a1,a1,-4       # pointing to end of array (address)
    # Calculating size of array
    sub a1,a1,a0        # t0 = ending address - starting address
    srli a1,a1,2        # t0 = t0/4 ( t0 >> 2) > since word has size of 4 bytes
                        # t0 will contain the size
#    jal test_loop
    jal reverse_array

    j end               # end of code

# function (arg1=*array,arg2=size)
reverse_array:
    li t0, 0            # initialize counter to 0
    addi t1,a1,-1        # since index starts from 0, index = size - 1
    slli t1,t1,2        # converting size into bytes ( size << 2 ) > ( size*4 )
    add t1,a0,t1        # starting_address(a0) + (size*4)(t1) = ending address (t1)
    srli a1,a1,1        # loop will run till (size/2)
#    addi a1,a1,1
loop:
    lw t2, 0(a0)        # load word from top of array
    lw t3, 0(t1)        # load word from end of array
    # swapping elements (top <> end)
    sw t2, 0(t1)        # store top element at end of array
    sw t3, 0(a0)        # store end element at top of array
    # point address to next element
    addi a0,a0,4        # a0 = a0 + 4 bytes (increment in address)
    addi t1,t1,-4       # t1 = t1 - 4 bytes (decrement in address)

    addi t0,t0,1        # increment in counter
    ble t0,a1,loop      # if counter <= size, jump to loop

    ret                 # return at ra

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
