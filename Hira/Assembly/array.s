.global _start



.section .data 
array: .word 1,2,3,4
size:  .word 4

.section .text 

iterate_through_array:
	#t1= points to array
	#a0=size of array
	#a1=hold the value
	li a2,0		    #i=0
	
	beq a2,a0,func_end  # if(size==i)-> break
        lw a1,0(t1)         #a1=array[t1]
        addi t1,t1,4
        addi a0,a0,-1       #size--
	j iterate_through_array
	func_end:
	ret

_start:
	la t1, array   # for index in order
	la t2, array   # for indexing in reverse order


	#some basic initializations
	li a0,0	       # loop condition
	lw a1, size    # length of array
	li a2, 4       # size of each element
	li a6, 1       # temp variables
	
	
loop:
	#a3= array[i]
	#a4=array[size-i]
	
	beq a1,a0,done  # if(size==0)-> break
	#code for accessing array in order
	lw a3,0(t1)	#array[i]


	addi a0,a0,1	#(i++)			
	addi a1,a1,-1   # size--	

	#Code for accessing array in reverse order
	mul a6, a1,a2	# a6 = size * 4 
	add t2,t2,a6	# t2=t2+a6 
	lw a4, 0(t2)	# a3=array[size-i]

	#swapping 
	sw a3,0(t2)	# value of array[i]
	sw a4,0(t1)	# value of array[size-i]
	
	#setting the values of pointers
	add t1,t1,a2	# t1=t1+4
	sub t2,t2,a6	# reinitializing t2


	j loop		#loop

done:
	#iteraying through array to verify the answer
	la t1, array
	lw a0,size
	jal ra,iterate_through_array	

	
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
