.global _start
.section .data
array: .word 23, 1, 10, 5, 2
size: .word 5

.section .text
_start:
    la x1, array       # Load base address of array
    lw x3, size        # Load size of array into x3

    addi x5, x0, 1     # i = 1

forloop:
    bge x5, x3, done   # if (i >= n) exit loop
    slli x6, x5, 2     # x6 = i * 4 (element size)
    add x7, x1, x6     # x7 = address of arr[i]
    lw x2, 0(x7)       # key = arr[i]
    addi x4, x5, -1    # j = i - 1

whleloop:
    blt x4, zero, endloop # if (j < 0) exit while
    slli x8, x4, 2      # x8 = j * 4
    add x9, x1, x8      # x9 = address of arr[j]
    lw x10, 0(x9)       # x10 = arr[j]

    ble x10, x2, endloop # if (arr[j] <= key) exit while

    add x11, x9, x4     # address of arr[j + 1]
    addi x11, x11, 4    # address of arr[j + 1]
    sw x10, 0(x11)      # arr[j + 1] = arr[j]
    addi x4, x4, -1     # j = j - 1
    j whleloop

endloop:
    slli x8, x4, 2      # x8 = j * 4
    add x9, x1, x8      # x9 = address of arr[j + 1]
    addi x9, x9, 4      # address of arr[j + 1]
    sw x2, 0(x9)        # arr[j + 1] = key
    addi x5, x5, 1      # i = i + 1
    j forloop

done:
  

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
