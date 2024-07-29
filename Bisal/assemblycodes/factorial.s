#  ============================================================================
#  Filename:    factorial.s 
#  Description: File consists of code to calculate factorial of number
#  Author:      Bisal Saeed
#  Date:        7/12/2024
#  ============================================================================


.section .text
.globl _start

_start:
    li   a0, 5         
    li   t0, 1         # t0 will store the factorial result
    li   t1, 1         # t1 will be the counter

check:
    addi t2, t1, 1
    # check conditions if a0 is reached 
    ble  t1, a0, compute_factorial  
    j    done                       

compute_factorial:
    mul  t0, t0, t1    # t0 = t0 * t1 
    mv   t1, t2        # increment counter
    j    check     
    
done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0


