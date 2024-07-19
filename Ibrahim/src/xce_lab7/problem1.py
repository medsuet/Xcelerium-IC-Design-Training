import random

# Function to add 2 numbers
def add(a, b):
    return a + b

# Function to subtract 2 numbers using two's complement
def sub(a, b):
    return a + (~b + 1) 

# Function to right shift the combined accumulator and multiplier
def right_shifting(multiplier, accumulator, Q_1, lsb_multiplier):
    # Handle negative multiplier by converting it to unsigned
    if (multiplier < 0):
        multiplier = multiplier + (1 << 32)
    
    # Combine accumulator and multiplier in one variable
    combined = (accumulator << 32) | multiplier 
    # Perform the right shift
    combined >>= 1  
    
    # Update Q_1 with the lsb of multiplier
    Q_1 = lsb_multiplier 
    
    # Return the shifted data and updated Q_1
    return combined, Q_1

# Booth's multiplier implementation
def boothMultiplier(multiplicand, multiplier):
    accumulator = 0
    lsb_multiplier = 0
    Q_1 = 0
    count = 32  
    
    # Count is 32 for 32-bit Booth's multiplier
    for _ in range(count):
        # Extract lsb of multiplier
        lsb_multiplier = multiplier & 1
        if ((lsb_multiplier == 1) & (Q_1 == 0)):
            # If lsb is 1 and Q_1 is 0, subtract multiplicand from accumulator
            accumulator = sub(accumulator, multiplicand)
        elif ((lsb_multiplier == 0) & (Q_1 == 1)):
            # If lsb is 0 and Q_1 is 1, add multiplicand to accumulator
            accumulator = add(accumulator, multiplicand)
        
        # Perform right shift and update Q_1
        product, Q_1 = right_shifting(multiplier, accumulator, Q_1, lsb_multiplier)
        # Split the combined product back into accumulator and multiplier
        accumulator = (product >> 32) 
        multiplier = product & 0xFFFFFFFF
    
    # Return the final product
    return product

# Function to generate random test cases for 32-bit numbers
def generateRandomTestCases(num_cases):
    test_cases = []
    for _ in range(num_cases):
        multiplicand = random.randint(-2**31, 2**31 - 1)
        multiplier = random.randint(-2**31, 2**31 - 1)
        expected = multiplicand * multiplier
        test_cases.append((multiplicand, multiplier, expected))
    return test_cases

# Function to test the Booth multiplier
def testBoothMultiply():
    # Predefined test cases
    test_cases = [
        [-146, -146, 21316],
        [5, 3, 15],
        [5, -3, -15],
        [-5, -3, 15],
        # Multiplication by zero
        [0, 5, 0],
        [5, 0, 0],
        # Highest 32 bit numbers
        [2**31 - 1, 2**31 - 1, (2**31 - 1)**2],
        [(2**31 - 1), 2, ((2**31-1)*2)],
        [1, 2**31 - 1, 2**31 - 1],
        [-1, 2**31 - 1, -(2**31 - 1)],
        [1, -2**31, -2**31],
        [-1, -(2**31 - 1), 2**31 - 1]
    ]
    
    # Generate random test cases
    test_cases.extend(generateRandomTestCases(10))

    for multiplicand, multiplier, expected in test_cases:
        result = boothMultiplier(multiplicand, multiplier)
        # Print the results and check if the test case passed or failed
        print(f"Multiplicand: {multiplicand}, Multiplier: {multiplier}, Expected: {expected}, Result: {result}")
        if result != expected:
            print("Test case failed!")
        else:
            print("Test case passed.")

def main():
    testBoothMultiply()

if __name__ == "__main__":
    main()
