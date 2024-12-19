.global _start
.section .text

_start:
    li a0, 176           # dividend Q
    li a1, 51            # divisior M
    li a2, 0            # Accumlator A
    li a3, 32           # number of bits
    beq a1,zero, done   #Math error

restoring_division:

    srli t0, a0, 31     # t0 = Q_msb
    slli a0, a0, 1      # left shift Q by 1
    slli a2, a2, 1      # left shift A by 1
    or   a2, a2, t0     # set the msb of Q has lsb of A

    sub a2, a2, a1      # A = A-M

    srli t1, a2, 31     # t1 = A_msb

    beq t1, zero, mask; # if A_msb == zero then mask

    li t2, 0xfffffffe
    and a0, a0, t2  #for making Q(0) = 0
    add a2, a2, a1      # A= A+M
    
    addi a3, a3, -1     # n= n-1
    beq a3, zero, done  # when n goes to zero
    j restoring_division

mask:
    ori a0, a0, 0x01    #for making Q(0) = 1
    addi a3, a3, -1     # n= n-1
    beq a3, zero, done  # when n goes to zero
    j restoring_division


# Signal test pass to Spike
done:
    li t0, 1
    la t1, tohost
    sw t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
