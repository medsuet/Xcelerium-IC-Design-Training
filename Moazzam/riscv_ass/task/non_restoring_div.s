.global _start
.section .text

_start:
    li a0, 176           # dividend Q
    li a1, 51            # divisior M
    li a2, 0            # Accumlator A
    li a3, 32           # number of bits
    beq a1,zero, done   #Math error
    li t0, 0x80000000

non_restoring_division:
    
    and t1, a2, t0      # checking 31 bit of A

    beq t1, zero, cond_1 # if 31-bit is zero jump to cond_1
    jal left_shift      # jump to left_shift and save position to ra
    add a2, a2, a1      # A = A+M
    j mask_Q

cond_1:
    jal left_shift  # jump to left_shift and save position to ra
    sub a2, a2, a1      # A = A-M
    

mask_Q:
    and t1, a2, t0      # checking 31 bit of A

    beq t1, zero, mask_Q_or
    li t4, 0xfffffffe   
    and a0, a0, t4      #Q = Q & 0xfffffffe;
    addi a3, a3, -1     # n= n-1
    beq a3, zero, last_step  # when n goes to zero
    j non_restoring_division

mask_Q_or:
    ori a0, a0, 0x01
    addi a3, a3, -1     # n= n-1
    beq a3, zero, last_step  # when n goes to zero
    j non_restoring_division

last_step:

    and t1, a2, t0      # checking 31 bit of A

    beq t1, zero, done
    add a2, a2, a1
    j done

left_shift:
    srli t2, a0, 31     # t2 = Q_msb
    slli a0, a0, 1      # left shift Q by 1
    slli a2, a2, 1      # left shift A by 1
    or   a2, a2, t2     # set the msb of Q has lsb of A
    ret



# Signal test pass to Spike
done:
    li t0, 1
    la t1, tohost
    sw t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
