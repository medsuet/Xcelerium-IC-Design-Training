#  ============================================================================
#  Filename:    sort.s 
#  Description: File consists of code based for insertion sort algorithm
#  Author:      Bisal Saeed
#  Date:        7/12/2024
#  ============================================================================

.globl _start
_start:
    .data
    .align 2
array:
    .word 5, 2, 4, 6, 1, 3    
array_size = (. - array) / 4  # Calculate array size in words
    la   t0, array       # address of array 
    li   t1, 1           # counter variable

outer_loop:
    # exit if t1 > = array size 
    bge  t1, array_size, end_sort  
    # Inner loop
    mv   t2, t1           # t2 = i (index of element to be inserted)
    lw   t3, 0(t0)        # Load array[i] into t3
    li   t4, 0            # Initialize (index for comparison)
    
inner_loop:
    blt  t4, t2, check_next  
    lw   t5, 0(t0 + t4*4)    # Load array[j] into t5
    blt  t3, t5, shift       # Exit loop if array[i] >= array[j]
    addi t4, t4, 1           
    j    inner_loop        

shift:
    mv   t5, t2            # t5 = i
    
shift_loop:
    bne  t5, t4, done
    lw   t6, 0(t0 + t5*4)  # Load array[t5] into t6
    sw   t6, 0(t0 + t5*4)  # Store array[t5] into array[t5+1] (shift right)
    addi t5, t5, -1       
    j    shift_loop        

shift_end:
    sw   t3, 0(t0 + t4*4)  # Store array[i] into array[j] (correct position )
    addi t1, t1, 1         
    j    outer_loop        

done:
    # Signal end of program (for Spike simulator)
    li t0, 1
    la t1, tohost
    sd t0, (t1)
    # Loop forever to stop the program from continuing
1:  j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

