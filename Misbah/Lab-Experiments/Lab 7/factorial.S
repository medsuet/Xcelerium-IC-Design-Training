.section .text
.globl _start

countbits:
 addi t0, zero, 0 #count initialized to zero
 beq a0, zero, end

factorial:
 addi sp, sp, -16
 sw ra, 12(sp)
 sw a0, 8(sp)

 bnez a0, loop
 li a0, 1
 j  end_function

loop:
 addi a0,  a0,  -1
 jal ra, factorial
 lw t1, 8(sp)
 mul a0, a0, t1

end_function:
 lw ra, 12(sp)
 addi sp, sp, 16 

end:
 mv a0, t0
 ret

_start:
 li  a0, 43

 jal ra, countbits

 sw a0, 0(t0)

 j .

.section .data
message:
    .string "The factorial of the number is: "
newline:
    .string "\n"


.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
