# Name: problem2.s
# Author: Muhammad Tayyab
# Date: 11-7-2024
# Description: Count the number of set bits in a 32-bit word

.global _start

function:
    andi t1, t0, 1          # store lsb of number in t1
    beq t1, x0, basecase    # if t1==0
    addi t5, t5, 1          # else increment t5
basecase:
    addi t4, t4, -1         # decrement number of bits to check
    beq t4, x0, return      # if no bits remaining, return
    srli t0, t0, 1          # else shift t0 right by 1
    J function              # run function again (loop)
return:
    jalr x0, ra                    # return to main

.section .text
_start:
    li t4, 4                # number of bits to check
    li t5, 0                # stores count of set bits
    li t0, 0xE                # number to count bits of
    jal ra, function        # call function

end:
    # Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
