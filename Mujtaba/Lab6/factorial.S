.section .data
x: .word 5
z: .space 4


.section .bss
    .align 4
_stack_top:
    .space 1024 


.section .text
.global _start

factorial:
	addi sp, sp, -8  # Allocate the 8 bytes of size on stack
	sw a0, 4(sp)     # Push arguments on the stack
	sw ra, 0(sp)	 # Push the retrun address on to stack
	li t0, 1		 # Base Case 
	blt t0, a0, else # if t0 < a0 then else
	addi a0, zero, 1 # otherwise return 1
	addi sp, sp, 8   # Free the stack allocated memory
	ret              # ret back to the return address

else:
	addi a0, a0, -1  # else branch n - 1
	jal factorial    # jump to factorial
	lwu ra, 0(sp)    # load address of return address
	lw t1, 4(sp)     # load the argument
	addi sp, sp, 8   # Free the stack memory
	mul a0, t1, a0   # a0 = a0 * t1
	ret				 # return to address

_start:
	# Initialize the stack memory and after configuring the arguments call the factorial function
	la sp, _stack_top 
	lw a0, x
	jal factorial
	la s0, z
	sw a0, 0(s0)
	j done

done:
	# Spike signal to quit
	li t0, 1
	la t1, tohost
	sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
