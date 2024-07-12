.global _start

# data section
.section .data
    number1: .word 5  # number1 assigned 32 bits - 4 bytes
    number2: .word 15 # number2 assigned 32 bits - 4 bytes
    absoluteNegative: .word 0x7FFFFFFF # used to convert negative number to positive

# Code section
.section .text
# start the program here
_start: 
    la t0, number1       # auipc t0, 0(t0) -> addi    t0, t0, 56 - load address of number1 in x5 = pc+offset=pc +number1 
    lw t2, 0(t0)         # x2 = t2 = 5 load value from address x5 in x7
    la t0, number2       # auipc t0, 0(t0) -> addi    t0, t0, 48 - load address of number2 in x5=
    lw t3, 0(t0)         # load value from address x5 in a7
    sub t4, t2, t3
    
    
           # x9 = x7 - x8
    bgez t4, end

    neg t4,t4

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
