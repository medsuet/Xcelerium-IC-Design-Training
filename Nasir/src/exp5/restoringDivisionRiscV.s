.global _start

# data section 
.section .data
    dividend: .word 20 # 20 will be stored in dividend variable on stack
    divisor: .word 1   # 3 will be stored in variable divisor
    quotient: .word 0  # 0 will be stored in variable quotient
    remainder: .word 0 # 0 will be stored in variable remainder
# code section

.section .text

_start:
    la t0, dividend  # load address of dividend in t0
    lw t1, (t0)      # store value at address 0 in t1 = dividend
    la t0, divisor   # load address of divisor in t0
    lw t2, (t0)      # store value at address 0 in t1 = divisor
    la t0, quotient  # load address of quotient in t0
    lw t3, (t0)      # store value at address 0 in t1 = quotient
    la t0, remainder # load address of remainder in t0
    lw t4, (t0)      # store value at address 0 in t1 = remainder
    li t5, 0x80000000 # sign bit is set
    li t6, 32          # loop counter - loop end register value
    li x10, 1          # store 1 in x10

loop:
    slli t4, t4,1       # shift left remainder by 1 bit 
    and x11, t1, t5     # extract sign bit of dividend
    srli x11, x11, 31   # store sign bit of dividend in x11
    or t4, t4,x11       # replace lsb of remainder with x11, a sign bit of dividend
    slli t1, t1,1       # shift left dividend by 1 bit
    addi x12, t4,0          # store remainder in x12 for restoring it 
    sub t4,t4,t2        # remainder = remainder - divisor
    and x13, t4, t5     # extract sign bit of remainder
    srli x13, x13, 31   # store sign bit of remainder in x13
    beq x13, x10, updateQuotient0RestoreA      # if x13 == x10 =1 then updateQuotient0RestoreA
    beqz x13, updateQuotientOne                # if x13 == 0 then updateQuotientOne 
    
updateQuotient0RestoreA:  # A = Remainder
    slli t3, t3, 1        # update quotient by q[0] = 0
    addi t4, x12, 0       # restore remainder
    j decrementLoop       # jump to decrementLoop

updateQuotientOne: 
    slli t3, t3, 1      # shift left
    or t3, t3, 1        # set q[0] = 1
    j decrementLoop     # jump to decrementLoop

decrementLoop:
    sub t6, t6, x10  # decrement loop counter by 1
    bnez t6, loop    # if t6 != 0 go to loop

end:

    la t0, quotient   # load address of quotient in t0  
    sw t3, (t0)       # store final quotient back to memory
    la t0, remainder  # load address of remainder in t0
    sw t4, (t0)       # store final remainder back to memory
    
# Code to exit for Spike (DONT REMOVE IT)
    li t0, 1
    la t1, tohost
    sd t0, (t1)
    # Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0


