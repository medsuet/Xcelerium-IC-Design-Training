.global _start
.section .text

_start:
    li a0, 7                        # Initialize 32_bit number 
    li a1, 0                        # Initialize count set_bits
    li a4, 32                       # 32_bit_check
    
count_bits:
    andi a2, a0 ,0x01               # a2 --> bit_check
    add a1, a1, a2                  # a1 = a1 + a2
    srli a0, a0, 1
    addi a3, a3, 1                  # bit count
    beq a3, a4, done                # if a3 == a4 then target
    bne a0, zero ,count_bits 

# Signal test pass to Spike
done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
