#programe to find absolute difference between two numbers;
.global _start
.section .text
_start:

addi x5, x0, 5 #number to find fictorial
addi x1, x0, 1 #initial value of int i=1
addi x8, x0, 1 #initial value of fic=1
loop:
    bgt x1, x5, label1
    mul x8, x8, x1 #fic = fic*i
    addi x1, x1, 1 #i=i+1
    j loop
label1:              #result is x8 = 0x0000000000000078 it mean  7*16^1+ 8*16^0 = 120
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
