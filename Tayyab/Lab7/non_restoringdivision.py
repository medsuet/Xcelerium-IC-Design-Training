"""
Name: non_restoringdivision.py
Date: 15-7-2024
Author: Muhammad Tayyab
Description: Non restoring division algorithem for 32 bit integers
"""

import random

def getbit(number, n):
    """
    Returns nth bit of number (lsb is bit 0)
    """
    return (number >> n) & 1

def nonRestoringDivision(Q,M):
    """
    Non restoring division algorithem for 32 bit integers
    Arguments: Q: dividend      M: divisor
    Returns: (Q,A): tuple of quotient, remainder
    """
    # Division by zero case
    assert (M != 0), "Division by zero!"

    A = 0
    n = 32

    for i in range(n, 0, -1):
        print(f"i:{i} \nQ: {bin(Q)} \nA: {bin(A)}\n")
        signbit_A = getbit(A, n-1)

        # Shift AQ left
        msb_Q = getbit(Q, n-1)
        A = (A << 1) & (~(1<<n))
        Q = Q << 1 & (~(1<<n))
        A = A | msb_Q               # place msb of Q at lsb of A

        if (signbit_A == 1):
            A = A + M
        else:
            A = A - M
        
        signbit_A = getbit(A, n-1)
        if (signbit_A == 1):
            Q = Q & (~1)
        else:
            Q = Q | 1

    signbit_A = getbit(A, n-1)
    if (signbit_A == 1):
        A=A+M

    A = A % (1<<n)

    return (Q, A)

# Random tests
numTests = 1
testNumRange = 1e6

for i in range(int(numTests)):
   num1 = random.randint(0,testNumRange)
   num2 = random.randint(1 ,testNumRange)
   num1 = 5
   num2 = 2
   test_results =  nonRestoringDivision(num1, num2)
   correct_results = num1//num2, num1%num2
   if (test_results != correct_results):
       print(f"Failed at {num1} x {num2}  ({i+1}th test)")
       break
else:
   print(f"Passed all {i+1} tests")
