#calculating absolute difference between two numbers
.global _start
.section .text

_start:

li t0, -5  #set number 1 
li t1, 10  #set number 2
li t2, 0  #reg to store absolute difference
li t3, -1 
sub t2, t0, t1 
bge t2, zero, end #checking if difference in neg or pos

if_neg: 
mul t2, t2, t3 #multiply -1 with difference if it is neg, so it become pos

end:
# Code to exit for Spike
li t0, 1
la t1, tohost
sd t0, 0(t1)

# Loop forever if spike does not exit
1: j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
