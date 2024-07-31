.global _start
.section .text

_start:
    li a0, 0x1234    # Initialize 32_bit number 
    li a1, 4        # bit position want to change
    li a2, 0       #  1 for set, 0 for clear
    
set_clear:
    li t0, 1
    sll t0,t0,a1    # mask value

    beq a2, zero, clear ; # if a2 == zero then clear
    or a0, a0, t0
    j done

clear:
    not t0, t0
    and a0, a0, t0

# Signal test pass to Spike
done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
