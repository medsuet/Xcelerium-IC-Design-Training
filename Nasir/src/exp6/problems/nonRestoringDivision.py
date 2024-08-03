#!/usr/bin/env python

# non restoring division
import random
import time
# shift left - combine remainder and dividend
def shiftLeft(remainder, dividend):
    result = (remainder << 32) | (dividend & 0xFFFFFFFF)
    result <<=1
    return result
# function to implement non restoring division
def nonRestoringDivision(dividend, divisor):
    if divisor == 0:
        return None, None  # Division by zero
    remainder = 0
    quotient = 0
    
    for i in range(32):
        #  calculate msb of remainder
        remainderMsb = remainder & (1 << 31)
        #  shift left remainder and dividend
        remainderDividendBound = shiftLeft(remainder, dividend)
        #  extract updated remainder 
        remainder = (remainderDividendBound >> 32) & 0xFFFFFFFF
        #  extract updated dividend
        dividend = (remainderDividendBound) & 0xFFFFFFFF
        # if remainder MSB = 1 a = a+m
        if remainderMsb:
            remainder += divisor
        # else a = a-m 
        else:
            remainder -= divisor
        # if updated remainder MSB = 1  Q[0] = 0
        if (remainder & (1 << 31)):
            quotient <<=1
        # else Q[0] = 1
        else:
            quotient= (quotient << 1) | 1
    # if remainderMSB = 1 a = a+m
    if (remainder & (1 << 31)):
        remainder+=divisor
         
    return (quotient & 0xFFFFFFFF) , (remainder & 0xFFFFFFFF)
# nonRestoringDivision(11,3)

# Function to run a test case
def runTestCase(dividend, divisor):
    quotient, remainder = nonRestoringDivision(dividend, divisor)
    
    if divisor == 0:
        if quotient is None and remainder is None:
            print("Division by zero handled correctly.")
        else:
            print("Test case failed: Division by zero not handled.")
        return

    expected_quotient = dividend // divisor
    expected_remainder = dividend % divisor

    print(f"Dividend: {dividend}, Divisor: {divisor}")
    print(f"Computed Quotient: {quotient}, Computed Remainder: {remainder}")
    print(f"Expected Quotient: {expected_quotient}, Expected Remainder: {expected_remainder}")

    if quotient == expected_quotient and remainder == expected_remainder:
        print("Test case passed.")
    else:
        print("Test case failed.")
    print("\n")

# Main function to run multiple test cases
def main():
    # Seed the random number generator
    random.seed(time.time())

    runTestCase(20, 3)
    runTestCase(1, 20)
    runTestCase(100, 10)
    runTestCase(4294967295, 1)
    runTestCase(1234567890, 987654321)
    runTestCase(11, 3)  # Added the original test case you provided
    runTestCase(random.randint(0, 100000), random.randint(1, 1000))
    # division by zero
    runTestCase(20, 0)
    # runTestCase(0, 0)

if __name__ == "__main__":
    main()        
            