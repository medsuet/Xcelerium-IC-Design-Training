.section .data
message:
    .string "The absolute difference between two numbers 3 and -6: "
newline:
    .string "\n"

.section .text
.globl _start
_start:
    # Load the values
    li a1, -3            # Load immediate value 3 into register a1
    li a2, -6           # Load immediate value -6 into register a2
    sub a3, a1, a2      # Compute a1 - a2 and store result in a3

    # Load address of message into t1
    la t1, message      
    la t0, tohost       # Load address of tohost into t0
    sw t1, 0(t0)        # Store the address of message into memory

    # Checking for negative result
    blt a3, zero, make_positive

print_result:
    # Convert the number in a3 to a positive ASCII digit
    addi a3, a3, 48     # Convert integer result to ASCII by adding 48
    sw a3, 0(t0)        # Store the ASCII value of the result

    # Load address of newline and store it
    la t1, newline      
    sw t1, 0(t0)        

    # Write a zero to tohost to indicate program completion
    li t1, 1
    sw t1, 0(t0)        

end:
    j end               # Infinite loop to keep the program running

make_positive:
    neg a3, a3          # Negate a3 to make it positive
    j print_result      # Jump to print_result to handle printing

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
