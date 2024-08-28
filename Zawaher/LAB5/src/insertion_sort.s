.global _start

.section .data  

array: .word 5,7,2,8,1
length: .word 5


.section .text

_start:
    #Loads the adress of the array and the length
    la t0, array #Loads the address into t0 
    lw t1, length

    #Initializing the pointers to array
    li t2, 0  #initalizing the  pointer (i)
    



sort_outer_loop:
    addi t2, t2, 1   # i = i + 1

    beq t2, t1,end_sort  # if t2 == t1 then target
    
    #Calculating the adress of pointers
    slli t3,t2,2   # 4 byte (1 word)
    add t3,t3,t0   # t3 = &array[i]
    lw t4, 0(t3)   # t4 = array[i]

    #j = i -1;

    addi s0, t2, -1

sort_inner_loop:
    blt s0,zero,sort_outer_loop  # if s0 zero t1 then target
    
    #Calculating the address for the j
    
    slli s1, s0, 2  # j = j*4
    add  s2, s1,t0  # s2 = &array[j]
    lw s3, 0(s2)    # s3 = array[j]
    addi s0, s0, -1 #  j = j-1
    blt t4, s3, swap # if t4 < s3, then swap
    bge t4, s3, sort_inner_loop # if t4 >= s3 then target
    
swap:
    sw t4, 0(s2)    # array[j] = t4
    sw s3, 0(t3)    # array[i] = s3

    #Updating the t3  
    addi t3,s2,0

    j sort_inner_loop 
    
end_sort:
# Signal test pass to Spike    
    li t0, 1
    la t1, tohost
    sd t0, (t1)

1: j 1b # Infinite loop  

.section .tohost 
.align 3
tohost: .dword 0
fromhost: .dword 0
