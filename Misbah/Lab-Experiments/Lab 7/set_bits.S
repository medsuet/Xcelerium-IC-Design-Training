# 0 "set_bit.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "set_bit.S"
.section .text
.global _start
.global SetBitsCounter

countbits:
 addi t0, zero, 0 #count initialized to zero
 beq a0, zero, end

loop:
 andi t1, a0, 1
 add t0, t0, t1
 srai a0, a0, 1
 bne a0, zero, loop

end:
 mv a0, t0
 ret

_start:
 li a0, 43

 jal ra, countbits

 sw a0, 0(t0)

 j .

.section .data
message:
    .string "Set Bits counter of 32 bit number: "
newline:
    .string "\n"


.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
