.global _start


.section .text


_binaryWidth:
	#a0 contains the number
	beq 



_start:
# Registers:
# x5 = Dividend (Q)
# x6 = Divisor (D)
# x7 = Remainder (R)
# x8 = Quotient
# x9 = Temp for shifts and comparisons
# x10 = Counter for number of bits

    li x5, 13          # Load dividend
    li x6, 3           # Load divisor
    li x7, 0           # Initialize remainder
    li x8, 0           # Initialize quotient
    li x10, 4          # Number of bits (for example purposes)

loop:
    sll x7, x7, 1      # Shift R left
    sll x9, x5, 31     # Shift MSB of Q into R
    srl x9, x9, 31     # Get MSB of Q
    or x7, x7, x9      # Combine with R

    sll x5, x5, 1      # Shift Q left

    sub x7, x7, x6     # Subtract divisor from remainder
    bge x7, x0, positive

    addi x8, x8, 0     # Set least significant bit of quotient to 0
    add x7, x7, x6     # Add back the divisor

    j end_subtract

positive:
    addi x8, x8, 1     # Set least significant bit of quotient to 1

end_subtract:
    sll x8, x8, 1      # Shift quotient left

    addi x10, x10, -1  # Decrement counter
    bnez x10, loop     # Repeat if not done

    srl x8, x8, 1      # Correct the final shift

# x8 contains the quotient
# x7 contains the remainder

	

	
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
