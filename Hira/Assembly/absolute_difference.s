.global _start


.section .text
_start:

	#loading some variables

        li a1, 20
	li a2, 5

	#checking is value a1 is greater then a2

	bgt a1,a2, greater
	sub a1,a2,a1
	
	j done
	
	#if num1>num2
	greater:
	sub a1,a1,a2
	

	
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


