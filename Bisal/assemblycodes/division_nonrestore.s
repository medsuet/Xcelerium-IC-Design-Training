#  =================================================================================
#  Filename:    division_nonrestore.s 
#  Description: File consists of code to implement non restoring division algorithm
#  Author:      Bisal Saeed
#  Date:        7/15/2024
#  ==================================================================================


.data
.align 2
divisor: .word 0x0       # Divisor placeholder
remainder: .word 0x0     # Remainder placeholder
quotient: .word 0x0      # Quotient placeholder

.text
.globl _start
_start:
    # Load dividend into x1 (for example, 100)
    li x1, 100
    # Load divisor into x2 (for example, 4)
    li x2, 4
    
    # Initialize variables
    mv x3, x0   # Quotient (initialize to 0)
    mv x4, x0   # Remainder (initialize to 0)
    
    # Loop for non-restoring division
    li t0, 32   # Loop counter (32 bits)
    li t1, 1    # Set initial mask (MSB set)

loop:
    # Shift remainder left by 1 (similar to multiplying by 2)
    slli x4, x4, 1
    
    # Set LSB of remainder with MSB of dividend
    srl x5, x1, 31     # Extract MSB of x1 (dividend)
    and x5, x5, t1     # Mask to get LSB of x1
    or x4, x4, x5      # Set LSB of remainder with MSB of dividend
    
    # Subtract divisor from remainder
    sub x4, x4, x2
    
    # If remainder < 0, add divisor back and set quotient bit to 0
    blt x4, x0, add_back
    add x4, x4, x2     # Add divisor back to remainder
    b continue
    
add_back:
    add x4, x4, x2     # Add divisor back to remainder
    li x5, 0           # Set quotient bit to 0
    sb x5, x3, t0      # Store quotient bit (0) at position t0
    
continue:
    # Shift quotient left by 1
    slli x3, x3, 1
    
    # Shift remainder left by 1
    slli x4, x4, 1
    
    # Decrement loop counter
    addi t0, t0, -1
    bnez t0, loop      # Loop until t0 != 0
    
    # End of division, x3 contains quotient, x4 contains final remainder

    # End of program
    ecall
