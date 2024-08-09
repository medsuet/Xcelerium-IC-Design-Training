.global _start 
.section .text
my_array:
    .word 3,4,1,6,5,2
array_size:
    .word 6

_start:
    #Load address of array_size in x1
    la x1,array_size
    #Load value of array_size in x1 from memory
    lw x2,0(x1)   # Size of array
    la x3,my_array  #Starting address is in x3 
    addi x4,x3,4    #Address of second element of array is in x4
    addi x5,x0,1
    addi x7,x3,4
    addi x8,x3,0  #x8 has starting address 
    addi x9,x3,4
Loop1:
    beq x5,x2,end #This loop will run (n-1) times
    addi x5,x5,1
    lw x10,0(x7)   #x10 has the current value
    addi x6,x7,-4
Loop2:
    blt x6,x8,Increment
    lw x11,0(x6)
    lw x10,0(x7)
    blt x10,x11,swap
    j Increment
swap:
    sw x10,0(x6)
    sw x11,0(x7)
    addi x7,x7,-4
    addi x6,x6,-4
j Loop2
Increment:
    addi x9,x9,4
    addi x7,x9,0

    j Loop1
end:
    # Code to exit for Spike (DONT REMOVE IT) 
    li t0, 1 
    la t1, tohost 
    sd t0, (t1) 
  
    # Loop forever if spike does not exit 
1:  j 1b
  
.section .tohost 
.align 3 
tohost: .dword 0
fromhost: .dword 0
