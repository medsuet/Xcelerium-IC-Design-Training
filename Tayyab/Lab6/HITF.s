.global _start
.section .text
_start:
 li t0, 0x10000000 # HTIF base address
 la t1, message # Load address of message
 
print_loop:
 lb t2, (t1) # Load byte from message
 beqz t2, done # If byte is zero, exit loop
 sw t2, 0(t0) # Write byte to HTIF
 addi t1, t1, 1 # Move to next byte
 j print_loop
done:
 # Signal test pass to Spike
 li t0, 1
 la t1, tohost
 sd t0, (t1)
 # Loop forever
1: j 1b

.section .data
message:
 .string "Hello, World!\n"
.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0