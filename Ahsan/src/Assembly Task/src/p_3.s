#Factorial of number
#Count number of set bits
.global _start
.section .text
_start:
#init the number whose factorial will be found
addi t0,zero,7
#init the result of fact
addi t1,zero,1
#init the number of iteration of for loop
addi t2,zero,1
#logic
factorial:
bgt t2,t0,done
mul t1,t1,t2
addi t2,t2,1

j factorial
done:
# Code to exit for Spike (DONT REMOVE IT)
li t0, 1
la t1, tohost
sd t0, (t1)
# Loop forever if spike does not exit
1: j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0