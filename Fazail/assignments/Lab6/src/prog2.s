.data
value: .word 10 # 32-bit value
count1: .word 1 # count 1's
bits: .word 4  # number of bits in value

.text
.global _start

_start:
    la t0, value            # Load address of value
    lw t1, 0(t0)            # Load value in t1

    la t2, count1
    lw t3,0(t2)             # load 1 in t2;

    la t4, bits
    lw t5,0(t4)             # number of bits in value

    addi a0, a0, 0          # initialize counter of set bits to zero
    li a1, 0                # initialize counter of 32 bits to zero
    addi a2, a2, 0          # initialize a2 with zero

loop:
    and a2, t1, t3          # a2 = 10 & 1 = 1 (0001)
    beq a2, t3, count
    j checksize

count:
    addi a0, a0, 1
    j checksize

checksize:
    beq a1, t5, end
    srli t1, t1, 1
    addi a1, a1, 1
    j loop

end:
    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, (t1)

    # Loop forever if spike does not exit
1: j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
