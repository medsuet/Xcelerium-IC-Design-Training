#programe to find absolute difference between two numbers;
.global _start
.section .text
_start:

addi x9, x0, 3 #the number for which we want to set and clear bits
addi x1, x0, 1 # I have stored for set bits
addi x2, x0, 1 # i have stored number for cleared bits

#for setting bit(n|=(1<<2)) if i want to set 2nd bit
slli x1, x1, 2 #here i shifted x1=1 by 2 bits right and store result in x1
or x5, x9,x1 # here i have take OR of x1 and x9 and store result in x5

#for clearing bit(n&=~(1<<3)) if i want to clear 3rd bit
slli x2, x2, 3 #here i shifted x2=1 by 3 bits right and store result in x2
not x2, x2 # for x2 = ~x2
and x7, x9, x2  #here i have take AND of x9 with x2 and store the result back in x7

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
