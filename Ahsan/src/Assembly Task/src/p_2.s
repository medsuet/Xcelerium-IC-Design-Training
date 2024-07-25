.global _start
.section .text
_start:
#giving the value for number
addi t0,zero,256
#initiazlizing the count to be zero
addi t1,zero,0
#logic for countung bits
count_bits:
beq t0,zero,done
andi t2,t0,1
add t1,t1,t2
srli t0,t0,1
j count_bits

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