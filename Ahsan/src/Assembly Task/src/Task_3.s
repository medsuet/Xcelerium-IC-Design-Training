#Restoring Algoritm
.global _start
.section .text
_start:
li a0,25      #dividend
li a1,5       #divisor
beqz a1,done  #if divisor is zero come out of function
li t0,64      #setting number of loops equal 64
li t1,0       # setting reminder to zero

division_loop:
beq t0,zero,outside_loop

#now making logic to check msb of A
srli s1,t1,63 #right shifting 63 bit to get msb

#decrementing t0
addi t0,t0,-1
#Left shift combine A and Q
slli t1,t1,1  #shift A by 1
srli t2,a0,63 #getting msb of quotient
or   t1,t1,t2 #combine it with A
slli a0,a0,1  #Shift quotient by 1

#now checking sign bit
beq s1,zero,subtracting
add t1,t1,a1
j next_check

subtracting:
sub t1,t1,a1

next_check:
#now again checking msb of A
srli s1,t1,63 
beq s1,zero,set_one
andi a0,a0,~1
j division_loop

set_one:
ori a0,a0,1
j division_loop

outside_loop:
#again checking sign bit
srli s1,t1,63 
beq s1,zero,done
add t1,t1,a1

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