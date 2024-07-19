def shift_left(A, Q):
    combined = (A << 32) | (Q & 0xFFFFFFFF)
    combined <<= 1
    A = (combined >> 32) & 0xFFFFFFFF
    Q = combined & 0xFFFFFFFF
    return A, Q

def division_algorithm(dividend, divisor):
    N = 32
    A = 0
    M = divisor
    Q = dividend
    
    while N != 0:
        A, Q = shift_left(A, Q)
        
        if A < 0:
            A = A + M
        else:
            A = A - M
        
        if A < 0:
            Q &= ~1
        else:
            Q |= 1
        
        N -= 1
    
    if A < 0:
        A = A + M
    
    quotient = Q
    remainder = A
    
    return quotient, remainder

# Test the algorithm
dividend = 5
divisor = 2
quotient, remainder = division_algorithm(dividend, divisor)
print(f"Quotient is {quotient} and remainder is {remainder}")

        
