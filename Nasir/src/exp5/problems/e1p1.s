.global _start

# data section - data memory
.section .data
    number1: .word 15  # number1 assigned 32 bits - 4 bytes
    number2: .word 10 # number2 assigned 32 bits - 4 bytes
    absoluteDifference: .word  # Variable absolute difference of above two numbers
    # absoluteNegative: .word 0x7FFFFFFF # used to convert negative number to positive

# Code section - instruction memory
.section .text
# start the program here
_start: 
    la t0, number1       # auipc t0, 0(t0) -> addi    t0, t0, 56 - load address of number1 in x5 = pc+offset=pc +number1 
    lw t2, 0(t0)         # x2 = t2 = 5 load value from address x5 in x7
    la t0, number2       # auipc t0, 0(t0) -> addi    t0, t0, 48 - load address of number2 in x5=
    lw t3, 0(t0)         # load value from address x5 in a7
    la t0, absoluteDifference # auipc,t0,0(t0) -> addi t0,t0,offset(address of absolute Difference)
    sub t4, t2, t3       # x9 = x7 - x8
    bgez t4, end         # if t4 >= 0 go to end
    neg t4,t4            # sub t4, zero, t4 - else takes twos complement

end:
    sw t4, 0(t0) # store absolute diffrence in memory
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
