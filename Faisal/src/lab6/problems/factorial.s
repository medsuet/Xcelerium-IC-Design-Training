/*  int num = 5;
    int result = 1;
    for(int i = num; i>=1; i--){
        result = result * i;
    }
    printf("%d\n",result);
    return 0;*/

.global _start
.section .text
.section .data
    num:    .word 5      # Number to compute factorial
    result: .word 1      # Initialize result to 1

_start:
    la t0, num
    lw t1, 0(t0)      # Load number into t1 (t1 = 5)

    la t0, result
    lw t2, 0(t0)          # Load the result into  t2 (t2 = 1)

factorial:
    beqz t1, done     # If t1 is 0, done
    mul t2, t2, t1    # t2 = t2 * t1
    addi t1, t1, -1   # t1 = t1 - 1
    j factorial  # Repeat

done:
    sw t2, 0(t0)      # Store the result

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


