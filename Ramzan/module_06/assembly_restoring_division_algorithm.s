.global _start
.section .text
.section .data
dividend: .word 56
divisor: .word 9
quotient: .word 0
remainder: .word 0

_start:
    # Set up stack pointer
    #la sp, stack_top

    # Load addresses of variables into registers
    la a1, dividend   # Load address of dividend into a1
    la a2, divisor    # Load address of divisor into a2
    la a4, remainder  # Load address of remainder into a4
    la a5, quotient   # Load address of quotient into a5

    addi t1, x0, 1    # this i have done for 1
    addi t2, x0, 0    # for i=0

    jal ra, restoringDivision
    j End

leftshift:
    lw t0, 0(a1)      # Load A in t0
    lw t1, 0(a2)      # Load Q in t1
    slli t0, t0, 1    # *A << 1
    srli t2, t1, 31   # *Q >> 31
    andi t2, t2, 1    # *Q >> 31 & 1
    or t0, t0, t2
    sw t0, 0(a1)      # Store updated value of A

    slli t1, t1, 1    # *Q << 1
    sw t1, 0(a2)      # Store updated value of Q
    jr ra             # Return to calling line

restoringDivision:
    addi x4, x0, 0    # A = 0
    addi x5, x0, 32   # n = 32
    lw x6, 0(a1)      # Q = dividend
    lw x7, 0(a2)      # M = divisor

loop:
    bge t2, x5, End   # if i >= n

    jal ra, leftshift
    sub x4, x4, x7    # A = A - M

    # Check MSB bit of A
    srli t3, x4, 31   # A >> 31
    andi t3, t3, 1    # (A >> 31) & 1

    beqz t3, label1
    not t1, t1        # 1 = ~1
    and t4, x6, t1    # (Q & ~1)
    ori x6, t4, 0     # Q = (Q & ~1) | 0
    add x4, x4, x7    # A = A + M
    j restore_result

label1:
    not t1, t1        # 1 = ~1
    and t4, x6, t1    # (Q & ~1)
    ori x6, t4, 1     # Q = (Q & ~1) | 1

restore_result:
    sw x6, 0(a5)      # *quotient = Q
    sw x4, 0(a4)      # *reminder = A
    addi t2, t2, 1    # i++
    addi x5, x5, -1   # n = n - 1
    j loop

End:
    j exit

exit:
li t0, 1
la t1, tohost
sd t0, (t1)

# Loop forever if spike does not exit
1: j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
