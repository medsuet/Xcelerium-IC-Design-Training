import random

def test(dividend, divisor):
        Q, A = non_restoring_division(dividend, divisor)
        original_quotient = dividend // divisor
        original_remainder = dividend % divisor
        if ( (Q == original_quotient) and (A == original_remainder)):
            print("Test passed")
            print(f"Quotient = {Q}, Remainder = {A}")
        else:
            print("Check your Algorithm")

def non_restoring_division(dividend, divisor):

    # Initialize variables
    A = 0
    Q = 0
    n = 32

    # Non-restoring division algorithm
    for i in range(n):
        # Shift left the A and add the next bit of the dividend
        A = (A << 1) | ((dividend >> (n - 1 - i)) & 1)

        # Subtract divisor from A
        A -= divisor

        if A < 0:
            # If A is negative, append 0 to Q and restore A
            Q = (Q << 1) | 0
            A += divisor
        else:
            # If A is non-negative, append 1 to Q
            Q = (Q << 1) | 1

    return Q, A

print(f"32-bit Unsigned Non-Restoring Division Algorithm")

value = int(input("Want to give the inputs (1) or check Random inputs (0):"))
assert value in (0,1), "You must give in the above input 0 or 1"

if (value == 1):
    dividend = int(input("\nEnter Dividend : "))
    divisor = int(input("Enter Divisor : "))
    #print(dividend // divisor)
    test(dividend, divisor)
else:
    max = (2**32) - 1
    for i in range (0,1000):
        dividend = random.randint(0,max)
        divisor  = random.randint(0,max)
        test(dividend, divisor)
        #print(i)


