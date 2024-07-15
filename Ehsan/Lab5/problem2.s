.global _start, _end, loop
.section .text

_start:

li t0, 31  #number
li t1, 0  #number of sets bits
li t2, 32 #set_counter
li t3, 0  #temp for storing lsb
li t4, 1  #temp for checking lsb is 1 (if (lsb == 1))
li t5, 0  #counter
loop:
    beq t5, t2, _end # if t0 == t1 then _end
    addi t5, t5, 1  #incrementing counter
    andi t3, t0, 1  #taking lsb of number
    srli t0, t0, 1  #shift right by 1 bit
    bne t3, t4, loop # if lsb != 1  then jump to _loop
    addi t1, t1, 1; # t1 = t1 + 1
    j loop

_end:
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
