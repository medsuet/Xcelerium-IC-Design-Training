def to_unsigned_32_bit(n):
    return n & 0xFFFFFFFF

def non_restoring_division(dividend, divisor):
    # Ensure inputs are within 32-bit unsigned integer range
    dividend = to_unsigned_32_bit(dividend)
    divisor = to_unsigned_32_bit(divisor)

    # Initialize
    n = 32  # Number of bits
    A = 0
    Q = dividend
    M = divisor

    # Check if divisor is zero
    if divisor == 0:
        print("Divisor cannot be zero")

    # Perform the algorithm
    for _ in range(n):
        # Shift left the combined AQ
        A = (A << 1) | ((Q & 0x80000000) >> 31)
        Q = (Q << 1) & 0xFFFFFFFF
        
        # Check the sign bit of register A
        if (A & 0x80000000):
            # if sign bit is 1(negative), perform A = A + M
            A = to_unsigned_32_bit(A + M)
        else:
            # if sign bit is 0(positive), perform A = A - M
            A = to_unsigned_32_bit(A - M)
        # another method to check sign bit sign_bit = (A >> 31) & 1
        if (A & 0x80000000):
            # Set Q[0] to 0
            Q = Q & 0xFFFFFFFE # set lsb to 0
        else:
            # Set Q[0] to 1
            Q = Q | 1 # set lsb to 1
    
    # Final correction if A is 1
    if (A & 0x80000000):
        A = to_unsigned_32_bit(A + M)
    
    return Q, A

# Example usage:
dividend = 111111
divisor =   22225

quotient, remainder = non_restoring_division(dividend, divisor)
print(f"Quotient: {quotient}, Remainder: {remainder}")
print(f"Expected Quotient:{dividend // divisor} Expected Remainder: {dividend % divisor}")
