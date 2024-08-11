#programe to find absolute difference between two numbers;
.global _start
.section .text
_start:

addi x1, x0, 0x5 #this is a 32-bit number
addi x2, x0, 0 #initialization of i for...forloop
addi x3, x0, 0 #store the result of number of sit bits
addi x4, x0, 0 #by default store zero

loop:
    beq x1, x4, label1  #if(x1==x4==0)
    andi x5, x1, 1 #to check either set bit is 1 or 0
    add x3, x3, x5 #to store result
    srli x1, x1, 1 #shift right logical by 1
    j loop
label1:
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
