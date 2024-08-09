.global _start

.section .text
_start:
    # Any code here
    li a0, 5                # Initializing a number
    li t0, 0                # Initializing counter to 0

    jal ra, countSetBits    # Storing return address in ra + jumping to function

    j end                   # end of script, answer in t0

countSetBits:
    andi s0,a0,1            # s0 = a0 & 1 - checking if LSB is 1 or 0
    add t0,t0,s0            # t0 = t0 + s0
    srli a0,a0,1            # a0 >> 1

    bnez a0,countSetBits    # while number is not 0, run the loop
    jalr zero, 0(ra)        # jump to return address


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
