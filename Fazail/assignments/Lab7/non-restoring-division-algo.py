import random

def test(dividend, divisor):
        quotient, remainder = non_restoring_division(dividend, divisor)
        original_quotient = dividend // divisor 
        original_remainder = dividend % divisor
        if ( (quotient == original_quotient) and (remainder == original_remainder)):
            print("Test passed")
            print(f"Quotient = {quotient}, Remainder = {remainder}")
        else:
            print("Check your Algorithm")
        
def non_restoring_division(dividend, divisor):
    # Ensure inputs are within the 32-bit unsigned range
    assert 0 <= dividend < 2**32, "Dividend out of 32-bit unsigned range"
    assert 0 <= divisor < 2**32, "Divisor out of 32-bit unsigned range"
    assert divisor != 0, "Divisor cannot be zero"

    # Initialize variables
    remainder = 0
    quotient = 0
    n = 32  # Number of bits for 32-bit unsigned integers

    # Non-restoring division algorithm
    for i in range(n):
        # Shift left the remainder and add the next bit of the dividend
        remainder = (remainder << 1) | ((dividend >> (n - 1 - i)) & 1)
        
        # Subtract divisor from remainder
        remainder -= divisor
        
        if remainder < 0:
            # If remainder is negative, append 0 to quotient and restore remainder
            quotient = (quotient << 1) | 0
            remainder += divisor
        else:
            # If remainder is non-negative, append 1 to quotient
            quotient = (quotient << 1) | 1

    return quotient, remainder

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


