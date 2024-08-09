.global _start

.section .text
_start:
    # Any code here
    li a0, 5            # First number: a
    li a1, 10           # Second number: b
    sub a2,a0,a1        # a2 = a0-a1
    blt a0,a1,neg
    j end

neg:
    sub a2,x0,a2       # will make a2 a positive number


end:
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
