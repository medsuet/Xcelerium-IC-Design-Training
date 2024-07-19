.global _start

.section .data
array: .word 3, 2, 5, 1, 6, 4
size: .word 6

.section .text

iterate_through_array:
    # t1 = points to array
    # a0 = size of array
    # a1 = holds the value
    li a2, 0             # i = 0

    iterate_loop:
        beq a2, a0, func_end  # if (size == i) -> break
        lw a1, 0(t1)          # a1 = array[i]
        addi t1, t1, 4        # Move to next element
        addi a2, a2, 1        # i++
        j iterate_loop
    func_end:
    ret

_start:
    la t1, array	
    lw a0, size          # Load size of array
    li a5, 0
    li a6, 4             # Element size (4 bytes for .word)

    li a0, 1             # i = 1
    li a4, 0             # key

    for_loop:
        bge a0, a1, done # if i >= size, exit loop
        
        mul a3, a0, a6   # a3 = i * element_size
        add t2, t1, a3   # t2 = &array[i]
        lw a4, 0(t2)     # key = arr[i]
        
        mv a2, a0        # j = i
        addi a2, a2, -1  # j = i - 1

        while_loop:
            blt a2, a5, end_while # if j < 0, break

            mul a3, a2, a6
            add t3, t1, a3        # t3 = &array[j]
            lw a7, 0(t3)          # a7 = arr[j]

            blt a7, a4, end_while # if arr[j] < key, break
            add t3, t3, a6        # move to arr[j+1]
            sw a7, 0(t3)          # arr[j+1] = arr[j]
            addi a2, a2, -1       # j--

            j while_loop
        end_while:
        mul a3, a2, a6
        add t3, t1, a3           # t3 = &array[j+1]
        add t3, t3, a6           # move to j+1 position
        sw a4, 0(t3)             # arr[j+1] = key

        addi a0, a0, 1           # i++
        j for_loop

    done:
        jal ra, iterate_through_array	

        # Exit code
        li t0, 1
        la t1, tohost 
        sd t0, 0(t1)

        # Loop forever
    1: j 1b

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
