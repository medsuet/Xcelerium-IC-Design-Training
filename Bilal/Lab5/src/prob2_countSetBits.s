# Problem No. 2
# Assembly programming
# Program to count the number of set bits in a 32-bit word

.global _start

func:
    andi a1, a0, 1          # store lsb of number in a1
    beq a1, x0, basic       # if a1==0
    addi a3, a3, 1          # else increment a3
basic:
    addi a2, a2, -1         # decrement number of bits to check
    beq a2, x0, return      # if no bits remaining, return
    srli a0, a0, 1          # else shift a0 right by 1
    J func                  # run func again (loop)
return:
    jalr x0, ra             # return to main

.section .text
_start:
    li a2, 4                # number of bits to check
    li a3, 0                # stores count of set bits
    li a0, 0xE              # number to count bits of
    jal ra, func            # call func

end:
    # Signal test pass to Spike
    li a0, 1
    la a1, tohost
    sd a0, (a1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
