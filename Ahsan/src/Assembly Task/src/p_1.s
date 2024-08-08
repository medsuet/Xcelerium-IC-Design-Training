.global _start
.section .text
_start:

#initializing values for two numbers to subtract
addi t0,zero,25
addi t1,zero,25

#subtracting two numbers
sub  t2,t1,t0

#checking if subtraction resuult is negative
blt t2,zero,negate
 
#result is non negative then
j done

#when result is negative
negate:
sub t2,zero,t2
#storing result
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
