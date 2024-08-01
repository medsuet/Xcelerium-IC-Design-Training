#Restoring Algoritm
.global _start
.section .text
_start:
li a0,25      #dividend
li a1,5       #divisor

beqz a1,done  #if divisor is zero come out of function
li t0,64     #setting number of loops equal 64
li t1,0       # setting reminder to zero

division_loop:
beq t0,zero,done
#decrementing t0
addi t0,t0,-1
#Left shift combine A and Q

slli t1,t1,1  #shift A by 1
srli t2,a0,63 #getting msb of quotient
or   t1,t1,t2 #combine it with A
slli a0,a0,1  #Shift quotient by 1
#Subtract divisor from A

sub t1,t1,a1
#now making logic to check msb of A
srli t3,t1,63 #right shifting 31 bit to get msb
beq t3,zero,non_restoring
add t1,t1,a1
andi a0,a0,~1
j division_loop

non_restoring:
ori a0,a0,1
j division_loop
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
