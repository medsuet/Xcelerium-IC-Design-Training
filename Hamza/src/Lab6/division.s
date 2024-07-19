
.section .text
.globl _start
_start:
    # Load dividend into register Q
    la t0, dividend     # Load address of dividend into t0
    lw t1, 0(t0)        # Load value at address in t0 into t1 (Q)

    # Load divisor into register M
    la t0, divisor      # Load address of divisor into t0
    lw t2, 0(t0)        # Load value at address in t0 into t2 (M)

    # Initialize A to 0
    li t3, 0            # Load immediate value 0 into A (t3)

    # Calculate number of bits (n)
    li t4, 32           # Load immediate value 32 (assuming dividend is 32-bit)

loop:
    # Step 2: Shifting A and Q to left
    slli t3, t3, 1      # Shift A left by 1
    srli t5, t1, 31     # Extract the most significant bit of Q
    andi t5, t5, 1      # Mask the LSB of Q
    or t3, t3, t5       # Update A

    slli t1, t1, 1      # Shift Q left by 1

    # Step 3: Subtracting M from A
    sub t6, t3, t2      # A - M
    mv t3, t6           # Update A

    # Step 4: Checking the most significant bit of A
    srli t6, t3, 31     # Extract the most significant bit of A
    andi t6, t6, 1      # Mask the LSB of A
    beqz t6, else_case  # If MSB of A is 0, jump to else_case
    andi t1, t1, -2     # Q & (~1)
    j end_loop          # Jump to end of loop

else_case:
    ori t1, t1, 1       # Q | 1

end_loop:
    addi t4, t4, -1     # Decrement loop counter
    bnez t4, loop       # Branch to loop if loop counter is not zero

    # Step 7: Extracting Quotient and Remainder
    sw t1, 0(t0)     # Store Q back to memory (quotient)
    sw t3, 0(t0)     # Store A back to memory (remainder)

    # Spike integration
    li t0, 1            # Value to signal success to Spike
    la t1, tohost       # Load address of tohost
    sd t0, (t1)        # Store value in tohost (signal to Spike)

    # Loop forever if Spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0

.section .data
    dividend:   .word 123     # Dividend 
    divisor:    .word 5       # Divisor
    Q:          .word 0       # Initialize Q to 0
    M:          .word 0       # Initialize M to 0
    A:          .word 0       # Initialize A to 0
    n:          .word 0       # Initialize n to 0

