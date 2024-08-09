.section .data
num1:       .word 2233333  # number whose bits will be counted (11 set bits in 2233333)
count:      .word 1        # This counter will go to 32 because we have a 32 bit number
result:     .word 0        #        
.global _start
.section .text
_start:
    la t0, num1  #load address of num1 in t0
    lw t1, 0(t0) #load the content at address t0 in t1

    la t0, count #load address of count in t0
    lw t2, 0(t0) #load the content at address t0 in t2
     
    li t5, 32    #this is the value at which counter will stop
    li t4, 0     #this register will contain the number of set bits in 32 bit number
loop: 
    # increment counter at every iteration to check each bit of the number
    sll t3, t1, t2    # Left shift t1 by t2 positions (to bring the target bit to the sign bit position)
    srl t3, t3, 31    # Right shift back to isolate the bit in the least significant bit position
    andi t3, t3, 1    # Isolate the least significant bit (to check if the target bit was set)
    la t0, result     # Load address of result into t0
    sw t3, 0(t0)      # Store the result in memory
    add t4, t4, t3    # add the lsb of t3 in t4. t4 is the register that keeps count of set bits in the given number

    addi t2, t2, 1    # Increment counter 
    ble t2, t5, loop  # Loop if counter <= 32
  
    # Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, (t1)
 # Loop forever if spike does not exit
1: j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
