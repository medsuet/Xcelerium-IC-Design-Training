
.global _start

.section .data
input_number:   .word 0xFFFFFFFF  # Example input number
bit_position:   .word 3           # Bit position to set or clear (0-31)
flag:           .word 1           # Flag: 1 for setting, 0 for clearing


.section .text 

_start:
	# Load input number into register x5
    	la t0, input_number
    	lw x5, 0(t0)

    	# Load bit position into register x6
    	la t1, bit_position
    	lw x6, 0(t1)

    	# Load flag into register x7
        la t2, flag
    	lw x7, 0(t2)

    	# Generate the bit mask
    	li t3, 1                # Load 1 into temporary register t3
    	sll t3, t3, x6          # t3 = 1 << bit_position; shift 1 left by bit position to create mask

    	# Check the flag to determine set or clear operation
    	beq x7, zero, clear_bit # If flag is 0, jump to clear_bit
    	# Set bit
    	or x5, x5, t3           # x5 = x5 | t3; set the bit

    	j done           # Jump to end_program

	clear_bit:
    	not t3, t3              # Invert the mask to have all 1s except the target bit
    	and x5, x5, t3          # x5 = x5 & t3; clear the bit


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
