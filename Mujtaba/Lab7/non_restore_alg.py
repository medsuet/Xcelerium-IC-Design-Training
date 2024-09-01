#!/usr/bin/env python3

def non_restore_alg(dividend, divisor):
    N = 32
    A = 0
    M = divisor & 0xFFFFFFFF
    Q = dividend & 0xFFFFFFFF
    while (N != 0):
        # Left shift A and Q combined
        A = (A << 1) | ((Q & 0x80000000) >> 31)
        Q = (Q << 1) & 0xFFFFFFFF

        if A & 0x80000000:  # If the sign bit of A is 1 (A is negative)
            A = A + M
        else:  # If the sign bit of A is 0 (A is non-negative)
            A = A - M

        if A & 0x80000000:  # If the sign bit of A is 1 (A is negative)
            Q = Q & ~1  # Set Q[0] to 0
        else:  # If the sign bit of A is 0 (A is non-negative)
            Q = Q | 1  # Set Q[0] to 1
        N -= 1  

    # Final correction if A is negative
    if A & 0x80000000:
        A = A + M    # Final correction if A is negative
    return Q, A

print(non_restore_alg(100,2))


