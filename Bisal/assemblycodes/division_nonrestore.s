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
    li x1, 100
    li x2, 4    
    # Initialize variables
    mv x3, x0  
    mv x4, x0   
    li t0, 32   
    li t1, 1    
loop:
    slli x4, x4, 1
    srl x5, x1, 31     # Extract MSB of x1 (dividend)
    and x5, x5, t1    
    or x4, x4, x5      # Set LSB of remainder with MSB of dividend
    sub x4, x4, x2
    # If remainder < 0, add divisor back and set quotient bit to 0
    blt x4, x0, add_back
    add x4, x4, x2    
    b continue 
add_back:
    add x4, x4, x2     
    li x5, 0          
    sb x5, x3, t0         
continue:
    slli x3, x3, 1
    slli x4, x4, 1
    addi t0, t0, -1
    bnez t0, loop  
done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)
1:  j 1b
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
