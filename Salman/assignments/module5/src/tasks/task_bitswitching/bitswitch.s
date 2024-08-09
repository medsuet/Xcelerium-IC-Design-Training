.global _start

.section .data
    num_input: .word 33791  # input number
    bit: .word 15           # bit to change
    action: .word 0         # 1 for set, 0 for clear

.section .text
.globl _start

_start:
    # Main
    la a0, num_input        # Load address for input number
    la a1, bit              # Load address for bit to change
    la a2, action           # Load address for action (set/clear)

    lw a0, 0(a0)            # input number
    lw a1, 0(a1)            # bit to change
    lw a2, 0(a2)            # action (set/clear)

    jal bitswitch           # jump to function

    j end                   # jump to end, end spike

# function (a0=input number, a1=bit to change, a2=action (set/clear))
bitswitch:
    addi t0,zero,1          # t0 = 0x00000001
    sll t0,t0,a1            # t0 = t0 << bits(a1)

    # if action is set or clear
    beqz a2,clear           # if a2 is zero, jump to clear
    # if a2 is one, don't jump to clear
set:
    or a0,a0,t0             # num = (num || t0)
    ret                     # answer in a0
clear:
    xori t0,t0,-1           # t0 XOR -1 >> not(t0)
    and a0,a0,t0            # num = num & t0
    ret                     # answer in a0

end:
    # Code to exit from SPIKE
    li t0,1
    la t1,tohost
    sd t0, (t1)


# Loop forever if spike does not exit
1:  j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
