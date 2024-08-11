.global _start
.section .text
.section .data

dividend: .word 56
divisor:  .word 9
quotient: .word 0
remainder: .word 0

_start:
    la a1, dividend   # Load address of dividend into a1
    la a2, divisor    # Load address of divisor into a2
    la a4, remainder  # Load address of remainder into a4
    la a5, quotient   # Load address of quotient into a5
    addi t1, x0, 0    # i = 0
    addi t5, x0, 1    # this i have done for 1

    jal ra, nonRestoringDivision
    j End

leftshift:
    lw t0, 0(a1)      # here i am loading A into t0
    lw t1, 0(a2)      # here i am loading Q into t1
    slli t0, t0, 1    # *A << 1
    srli t2, t1, 31   # here i have *Q >> 31 and store in t2
    andi t2, t2, 1
    or t0, t0, t2     # here *A << 1 | (*Q >> 31) & 1
    sw t0, 0(a1)      # here i have stored the updated A

    slli t1, t1, 1    # *Q << 1
    sw t1, 0(a2)      # here i have stored the updated Q
    jr ra             # Return to caller
nonRestoringDivision:
    addi x4, x0, 0    # A = 0
    addi x5, x0, 32   # n = 32
    lw x6, 0(a2)      # M = divisor
    lw x8, 0(a1)      # Q = dividend

loop:
    bge t1, x5, End   # Loop until i < n
    srl t3, x4, 31    # A >> 31
    andi x7, t3, 1     # signA

    jal ra, leftshift

    beqz x7, label1
    add x4, x4, x6    # A = A + M
    j check_sign_again

label1:
    neg x6, x6        # A = A - M
    add x4, x4, x6

check_sign_again:
    srl t3, x4, 31    # A >> 31
    andi x7, t3, 1     # signA

    not t5, t5
    beqz x7, label4
    and x8, x8, t5    # Q & ~1
    ori x8, x8, 0     # Q[0] = 0
    j next_check

label4:
    and x8, x8, t5
    ori x8, x8, 1     # Q[0] = 1

next_check:
    srl t3, x4, 31    # A >> 31
    andi x7, t3, 1     # signA

    beqz x7, End
    add x4, x4, x6    # A = A + M
    j restore_result

restore_result:
    sw x4, 0(a4)      # Store A at the address in a4 (remainder)
    sw x8, 0(a5)      # Store Q at the address in a5 (quotient)
    addi x5, x5, -1   # n = n - 1
    addi t1, t1, 1    # i = i + 1
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
