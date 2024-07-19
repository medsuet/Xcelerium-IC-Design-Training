       .data
num:          .word 0xF
bit_position: .word 3
value:        .word 0
      .text
      .global _start



_start:
lw x1, value           # x1 = value
lw x2,bit_position     # x2 = bit_position
lw x4,num              #x4 = num
addi x9,x0,1

beqz  x1, else
sll x3,x9,x2          #x3 = 1<<bit_position
or x4, x4,x3
j done

else:
sll x5,x9,x2
not x6,x5
and x4,x4,x6

done:
 la x5, num
 sw x4, 0(x5)

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
