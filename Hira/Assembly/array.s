.global _start



.section .data 
array: .word 3,5,2,1
size:  .word 4

.section .text 

_start:
	la t1, array   #address of array
	li a0, 0       #loop condition
	lw a1, size    # size of array0
	li a7,4	       #size of int
	
	
loop:
	beq a1,a0, done
	lw a2, 0(t1)	
	
	add t1,t1,a7	#for intrimenting the index
	mul a6,a1,a7
	lw a2, 0(a6)
	addi a1,a1,-1	#for iterating in size value

	
	lw a2, 0(t1)

	j loop

done:

        #Exit for spike
        li t0,1
        la t1,tohost
        sd t0,(t1)

#Loop forever
1: j 1b


.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
