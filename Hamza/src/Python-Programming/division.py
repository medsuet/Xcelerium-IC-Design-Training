import random

def shift_left(A, Q):
    temp = (A << 32) | (Q & 0xFFFFFFFF)
    temp = temp << 1
    A = (temp >> 32) & 0xFFFFFFFF
    Q = temp & 0xFFFFFFFF
    return A, Q

def non_restoring_division(dividend, divisor):
    N = 32
    A = 0
    Q = dividend
    M = divisor

    for _ in range(N):
        A, Q = shift_left(A, Q)

        if A & 0x80000000 == 0:  # If A is positive
            A = (A - M) & 0xFFFFFFFF
        else:
            A = (A + M) & 0xFFFFFFFF
        
        if A & 0x80000000 == 0:  # If A is positive
            Q = Q | 1
        else:
            Q = Q & 0xFFFFFFFE

    if A & 0x80000000 != 0:  # If A is negative
        A = (A + M) & 0xFFFFFFFF

    return Q, A

if __name__ == "__main__":
    # Generate random dividend and divisor
    dividend = random.randint(1, 1000)
    divisor = random.randint(1, 1000)

    quotient, remainder = non_restoring_division(dividend, divisor)

    print(f"Dividend: {dividend}, Divisor: {divisor}")
    print(f"Quotient: {quotient}")
    print(f"Remainder: {remainder}")
