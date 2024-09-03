.data
number: .dword 10 #number which we have to change bit
position: .dword 2 #which bit we have to change (63-0)
change_bit: .dword 1 #set bit(1) or clear bit(0)
.global _start
.section .text

_start:

la t0, number #load address of number in t0 
ld t1, 0(t0) #load number in t1

la t2, position #load address of position in t2
ld t3, 0(t2) #load position in t3

la t4, change_bit #load address of change_bit in t4
ld t5, 0(t4) #load change_bit in t5

beq zero, t5, clear_bit #if t5 = 0 means we have to clear the bit
li t6, 1
sll t6, t6, t3 #shift the set bit which we have to change
or t1, t1, t6 #set bit
j write_back

clear_bit: #clear_bit
li t6, 1
sll t6, t6, t3 #shift the clear bit which we have to change
not t6, t6     #taking not for clear bit
and t1, t1, t6 #clearing bit

write_back:    #writing back the number
sd t1, 0(t0)

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
