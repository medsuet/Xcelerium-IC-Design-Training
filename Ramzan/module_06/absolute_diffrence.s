#programe to find absolute difference between two numbers;
.global _start
.section .text
_start:

addi x1, x0, 7
addi x2, x0, 4
addi x6, x0, 0
bge x1, x2,label1
sub x6, x2, x1
j exit
label1:
    sub x6, x1, x2
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
