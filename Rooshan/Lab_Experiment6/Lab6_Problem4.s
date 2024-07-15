.global _start 
.section .text
my_array:
    .word 0x00000000000000001,0x00000000000000002,0x00000000000000003,0x00000000000000004,0x00000000000000005,0x00000000000000006
array_size:
    .word 6

_start:
    #Load address of array_size in x1
    la x1,array_size
    #Load value of array_size in x1 from memory
    lw x2,0(x1)   # Size of array
    addi x3,x0,0  # Index of first element of array
    srli x4,x2,1  # Divide array size by 2 to get index of middle value
    la x6,my_array  #Starting address
    la x7,my_array
    addi x8,x2,-1
    addi x9,x0,0

Multiply:
    addi x8,x8,-1
    addi x9,x9,4
    bne x8,x0,Multiply

    add x7,x7,x9   # Last address


Loop:
    bge x3,x4, end
    lw x10,0(x6)
    lw x11,0(x7)

    addi x12,x11,0    #Temporary Register x12
    sw x10,0(x7)
    sw x12,0(x6)

    addi x6,x6,4
    addi x7,x7,-4

    addi x3,x3,1
    j Loop

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
