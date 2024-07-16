#  ============================================================================
#  Filename:    factorial.s 
#  Description: File consists of code to calculate factorial of number
#  Author:      Bisal Saeed
#  Date:        7/12/2024
#  ============================================================================


.section .text
.globl _start

_start:
    # Initialize number
    li   a0, 5         # Compute factorial of 5

    # Initialize variables
    li   t0, 1         # t0 will store the factorial result, initialize to 1
    li   t1, 1         # t1 will be the counter, start from 1

check:
    addi t2, t1, 1
    # check conditions if a0 is reached 
    ble  t1, a0, compute_factorial  
    j    end                        

compute_factorial:
    mul  t0, t0, t1    # t0 = t0 * t1 (multiply current factorial by current counter)
    mv   t1, t2        # Update t1 to t2 (increment counter)
    j    check     # Repeat factorial

end:
    li   a7, 10        # syscall: exit
    ecall


