
.global _start


.section .data



.section .text

_start:

	li a0, 5   #input number initialization.
	li a1, 0   #register for condition
	li a2, 1   #register for answer
	li a3, 1  #counter for decrement

_factorial:
	beq a1, a0, done
	mul a2,a2,a0
	sub a0,a0,a3
	j _factorial

	


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

