.global _start

.section .data
    array: .word 25, 10, 15, 7, 30 # array
    size: .word 20 # array size
# code section

.section .text
_start:
    la t0, array     # store array address in t0 - 1st element address
    addi t1, t0,4    # second element address stored in t1
    la x20, size     # store address of size variable in x20
    lw t2, (x20)     # load size value in t2
    li t3, 4         # load 4 in t3
    sub t4,t2,t3     # t4 = t2 - t3
    li t5, 0         # t5 = 0 loop counter
    li x14, 4        # x14 = 0 used for adding 4
    li x10, 0        # x10 = 0 used for updating array elements address

loop:
    # addi x10, t5,0
    # addi x11, t5, 4
    add x17, t0, x10  # x17 = t0 + x10
    add x18, t1, x10  # x18 = t1 + x10
    # addi x19, t5,0
    li x19, 0         # x19 = 0 used iner loop counter
    addi x13, t5,4    # x13 = t5 + 4 - comparison variable for inner loop counter 

loopInterior:
    lw x15, (x17)    # load value from x17 to x15
    lw x16, (x18)    # load value from x18 to x16
    bgt x15, x16, swap  

updateAddresses:
    sub x17,x17,x14
    sub x18, x18, x14
    add x19, x19, x14
    # update address
    blt x19, x13, loopInterior
    j updateLoopCounter

swap:
    sw x15, (x18)
    sw x16, (x17)
    j updateAddresses

updateLoopCounter:
    addi t5, t5, 4
    add x10, x10,x14
    blt t5, t4, loop

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
