.global _start
.section .text

_start:
    li a0, 2                        # Initialize number 1
    li a1, 7                        # Initialize number 2
    blt a0, a1, check_condition     #(a0<a1)  then jump
    sub a2, a0, a1                  #a2 =a0 - a1
    j done
    
check_condition:
    sub a2, a1, a0


# Signal test pass to Spike
done:
    li t0, 1
    la t1, tohost
    sd t0, (t1)

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
