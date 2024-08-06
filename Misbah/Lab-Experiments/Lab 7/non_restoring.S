.section .text
.global _start
_start:
    addi x10, x0, 16
    addi x11, x0, 5
    addi x12, x0, 0
    addi x13, x0, 1
    slli x14, x13, 31
    addi x15, x0, 32
    xori x16, x11, -1
    addi x16, x16, 1

check_condition:
    bgt x15, x0, perform_loop
    and x17, x14, x12
    bne x17, x0, finish
    j end

perform_loop:
    addi x15, x15, -1
    and x17, x14, x12
    slli x18, x12, 1
    srli x19, x10, 31
    or x12, x18, x19
    slli x10, x10, 1

    beq x17, x0, add_divisor
    add x12, x12, x11
    j adjust_remainder

add_divisor:
    add x12, x12, x16

adjust_remainder:
    and x17, x14, x12
    beq x17, x0, set_msb
    xori x20, x13, -1
    and x10, x10, x20
    j check_condition

set_msb:
    or x10, x10, 1
    j check_condition

finish:
    add x12, x12, x11
end:
    li t0, 1
    la t1, tohost
    sw t0, (t1)

1: j 1b

.section .tohost
.align 2
tohost: .dword 0
fromhost: .dword 0
