def leftshift(A, Q):
    A = (A << 1) | ((Q >> 31) & 1)
    Q = (Q << 1) & 0xFFFFFFFF  # Keep Q within 32 bits
    return A, Q

def nonRestoringDivision(dividend, divisor):
    A = 0
    n = 32
    M = divisor
    Q = dividend
    for i in range(n):
        signA = (A >> 31) & 1
        if signA == 1:
            A, Q = leftshift(A, Q)
            A = (A + M) & 0xFFFFFFFF  # Keep A within 32 bits
        else:
            A, Q = leftshift(A, Q)
            A = (A - M) & 0xFFFFFFFF  # Keep A within 32 bits
        
        # Now check sign bit of A again
        signA = (A >> 31) & 1
        if signA == 1:
            Q = (Q & ~1) | 0  # Set Q[0] = 0
        else:
            Q = (Q & ~1) | 1  # Set Q[0] = 1

    if signA == 1:
        A = (A + M) & 0xFFFFFFFF  # Keep A within 32 bits
    return Q, A

def main():
    dividend = int(input("Enter a dividend:"))
    divisor = int(input("Enter a divisor:"))
    quotient, remainder = nonRestoringDivision(dividend, divisor)
    print("Quotient:", quotient)
    print("Remainder:", remainder)

if __name__ == "__main__":
    main()
