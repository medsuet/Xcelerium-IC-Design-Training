.global _start


.section .text
_start:

	li a0, 5        #original variable
	li a1,1		#register for add
	li a2,0		#register for counter
	li a3,0		#register for condition

_countBit:
	#check if the value is equal to zero jump
	beq a0,a3,done
	add a2, a0,a1  # add the lsb with 1 
	srl a0,a0,1    # logical right shift
	j _countBit    
	

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
