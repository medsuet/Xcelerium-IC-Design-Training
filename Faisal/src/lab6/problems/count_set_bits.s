.global _start
.section .text
.section .data
    word:    .word 5  # Example word
    count:   .word 0

_start:
    la t0, word
    lw t1, 0(t0)        # Load the word into t1

    li t2, 0            # Initialize count to 0

loop:
    beqz t1, store      # If t1 is 0, exit loop
    andi t3, t1, 1      # Extract the least significant bit
    add t2, t2, t3      # Add it to count
    srl t1, t1, 1       # Right shift t1 by 1
    j loop              # Repeat

store:
    la t0, count
    sw t2, 0(t0)        # Store the count

    # Code to exit for Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0

