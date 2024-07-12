.data
value: .word 5          # integer store in value

.text
.global _start

_start:
    la t0, value        # Load address of value
    lw t1, 0(t0)        # Load value in t1

    mv a0, t1

    jal ra, factorial   # Call factorial

    # Store the result somewhere or prepare for exit
    mv t0, a0           # Move result to t0

end:
    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, 0(t1)

    # Loop forever if spike does not exit
1: j 1b

factorial:
    addi sp, sp, -8     # Allocate Stack space
    sw ra, 0(sp)        # Save return address
    #sw s0, 0(sp)        # Save S0

    mv s0, a0           # Save argument in s0
    li t0, 1            # Initialize result to 1
    ble s0, t0, done    # if n <= 1, return 1

    addi a0, s0, -1     # n-1
    jal factorial       # Recursive call
    mul a0, a0, s0      # n * factorial(n-1)

done:
    lw s0, 0(sp)        # Restore s0
    lw ra, 4(sp)        # Restore return address
    addi sp, sp, 8      # Deallocate stack space
    jalr ra             # return

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

