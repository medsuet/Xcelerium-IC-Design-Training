import random

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
    random.seed()

    for i in range(5):
        multiplier = random.randint(-(2**31 // 2), 2**31 // 2)
        multiplicand = random.randint(-(2**31 // 2), 2**31 // 2)
        runTestCase(multiplicand, multiplier)

    # Test multiplication by zero
    runTestCase(10, 0)
    runTestCase(0, 10)
    
    # Test multiplication by one
    runTestCase(10, 1)
    
    # Test large values multiplication
    large_val1 = (2**31) - 1
    large_val2 = (2**31) - 1
    runTestCase(large_val1, large_val2)

if __name__ == "__main__":
    main()