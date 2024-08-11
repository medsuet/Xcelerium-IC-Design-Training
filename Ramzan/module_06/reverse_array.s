#programe to find absolute difference between two numbers;
.global _start
.section .text

array: .word 1,2,3,4,5 # intialize an  an array
empty_array: .space 20 #initialize an empty array(5*4=20 bytes)

_start:

la x8, array  #load array in x8
la x9, empty_array #load empty array in x9
addi x5, x0, 5 # terminate for loop
addi x1, x0, 0 #initialize for loop i=0
loop:
    beq x1, x5, label1 #if x1==x5 then end
    lw x2, 0(x8) #this shows that data present at offset at memory address of x8 load in x2
    sw x2, 0(x9) #this shows that data present in x2 store at memory address of x9 with offset x5
    addi x8, x8, 4 #if the address of the first element, the address of the second element is base_address + 4.
    addi x9, x9, -4 #in case of reverse we have to use base address-4
    addi x1, x1, 1 #this shows that offset will incremented by 1 on each iteration to fetch next element
    j loop
label1:
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
