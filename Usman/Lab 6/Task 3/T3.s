.data
N: .word 32
A: .word 0
M: .word 2
Q: .word 5
quotient: .word 0
remainder: .word 0

.text
.global _start

_start:
    la x10, A
    lw x1, 0(x10)  #x1 = A
    la x11, Q
    lw x2, 0(x11)   #x2 = q
    la x12, M
    lw x4, 0(x12) x4 = M
    la x13, N
    lw x6, 0(x13) #x5 = N

while:
    beqz x6, done       # If N == 0, jump to done
    slli x1, x1, 1      # A << 1
    srli x3, x2, 31     # Extract Q's MSB
    or x1, x1, x3       # Combine A and Q's MSB
    slli x2, x2, 1      # Q << 1

    blt x1, zero, jumpone
    sub x1, x1, x4      # A = A - M
    j skip_jumpone

jumpone:
    add x1, x1, x4      # A = A + M

skip_jumpone:
    blt x1, zero, jumptwo
    ori x2, x2, 1       # Q |= 1
    j skip_jumptwo

jumptwo:
    andi x2, x2, -2     # Q &= ~1

skip_jumptwo:
    addi x6, x6, -1     # N = N - 1
    j while

done:
    blt x1, zero, final_adjustment
    add x1, x1, x4      # Final adjustment: A = A + M

final_adjustment:
    la x20, quotient
    sw x2, 0(x20)       # Store quotient
    la x21, remainder
    sw x1, 0(x21)       # Store remainder

# Code to exit for Spike (DO NOT REMOVE IT)
li t0, 1
la t1, tohost
sd t0, 0(t1)

# Loop forever if Spike does not exit
1: j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

