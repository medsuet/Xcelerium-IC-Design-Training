#!/usr/bin/env python

# booth multiplier 

# function to calculate twos complement
def twoscomplement(multiplicand):
    return (~multiplicand + 1)

# Right Arithmetic Shift
def rightArithmeticShift(accumulator, multiplier):
    # concatenate accumulator and multiplier
    # if multiplier is negative
    # type cast into unsigned number
    if (multiplier < 0):
        multiplier = multiplier + (1 << 32)
    result = (accumulator << 32 ) | multiplier
    result >>=1
    return result
    

# function to calculate multiplication of two signed numbers or integers
def boothMultiplier(multiplicand, multiplier):
    # initialize accumulator and multiplierLsb and incremented bit of multiplier
    accumultor = 0
    multiplierLsb = 0
    incrementedQBit = 0
    # for loop upto length of signed integer
    for i in range(32):
        # extracting lsb of multiplier
        multiplierLsb = multiplier & 1
        # if 10  accumulator - multiplicand
        if ((multiplierLsb == 1) & (incrementedQBit == 0)):
            result = twoscomplement(multiplicand)
            accumultor = accumultor + result
        # if 01 accumulator + multiplicand
        elif ((multiplierLsb == 0) & (incrementedQBit == 1)):
            accumultor = accumultor + multiplicand
            
        # arithmetic right shift
        # cancatenation of accumulator and multiplier
        product = rightArithmeticShift(accumultor, multiplier)
        # extract updated accumulator and multiplier
        accumultorUpdated = (rightArithmeticShift(accumultor, multiplier) >> 32)
        multiplierUpdated = rightArithmeticShift(accumultor, multiplier) & 0xFFFFFFFF
        # update accumulator and multiplier
        accumultor = accumultorUpdated
        multiplier = multiplierUpdated
        # print(f"A: {accumultor}\n Q: {multiplier}\n")
        incrementedQBit = multiplierLsb
        
    return product

# Function to run a test case
def runTestCase(multiplicand, multiplier):
    result = boothMultiplier(multiplicand, multiplier)
    expected = multiplicand * multiplier

    print(f"Multiplier: {multiplier}, Multiplicand: {multiplicand}")
    print(f"Computed Result: {result}")
    print(f"Expected Result: {expected}")

    if result == expected:
        print("Test case passed.")
    else:
        print("Test case failed.")
    print()

# Main function to run multiple test cases
def main():
    import random

    # Seed the random number generator
    random.seed()

    # Run test cases
    print("'Multiplication by zero' \n")
    print("The result of 10 x 0 is: ", boothMultiplier(10, 0))
    print("The result of 0 x 10 is: ", boothMultiplier(0, 10), "\n")
    print("'Multiplication by 1' \n")
    print("The result of 10 x 1 is: ",boothMultiplier(0, 10))
    print("\n") 
    print("The result of 2**31-1 x 2**31-1 is: ", boothMultiplier(2**31-1, 2**31-1))
    print("Expected: ", (2**31-1) * (2**31-1))

    for i in range(10):
        print("\n###########################\n")
        # Generate a random number between 0 and RAND_MAX
        random_value = random.randint(0, 2**31 - 1)
        random_value2 = random.randint(0, 2**31 - 1)
        # Transform the random value to get a positive or negative value
        # This will map the range [0, RAND_MAX] to [-RAND_MAX/2, RAND_MAX/2]
        posNegRandomMultiplier = random_value - (2**31 // 2)
        posNegRandomMultiplicand = random_value2 - (2**31 // 2)

        print(f"The Multiplier is: {posNegRandomMultiplier}")
        print(f"The Multiplicand is: {posNegRandomMultiplicand}")

        multiplier = posNegRandomMultiplier
        multiplicand = posNegRandomMultiplicand
        result = boothMultiplier(multiplicand, multiplier)
        print(f"The Computed result of {multiplicand} and {multiplier} is: {result}")
        actual = multiplicand * multiplier
        print(f"Expected: {actual}")
        # checking test
        if result == actual:
            print(f"Test {i}: Passed")
        else:
            print(f"Test {i}: Failed")

if __name__ == "__main__":
    main()

