# Function to add 2 numbers
def add(a, b):
    return a + b

# Function to subtract 2 numbers
def sub(a, b):
    return a - b

# Function to right shift accumulator and multiplier
def right_shifting(multiplier, accumulator, Q_1, lsb_multiplier):
    # Combine accumulator and multiplier in one variable
    # Accumulator upper 32 bits and multiplier lower 32 bits
    combined = (accumulator << 32) | (multiplier & 0xFFFFFFFF)
    
    # Right shift accumulator and multiplier collectively
    combined = (combined >> 1) 
    
    # Set Q_1 bit to lsb of multiplier
    Q_1 = lsb_multiplier
    
    # Return the shifted data
    return combined, Q_1

def to_signed_32bit(n):
    # Convert to a signed 32-bit integer if the highest bit is set
    if n & 0x80000000:
        # Convert from unsigned to signed
        n -= 0x100000000
    return n

def boothMultiplier(multiplicand, multiplier):
    accumulator = 0
    lsb_multiplier = 0
    Q_1 = 0
    count = 32
    orgMultiplier = multiplier
    # print(f"{multiplier.bit_length()}")
    
    # Count is 32 for 32 bit booth multiplier
    for _ in range(count):
        # Extract lsb of multiplier
        lsb_multiplier = multiplier & 1
        if lsb_multiplier == 1 and Q_1 == 0:
            accumulator = sub(accumulator, multiplicand)
            # print(f"accumulator1 = {accumulator}, multiplier1 = {multiplier}")
        elif lsb_multiplier == 0 and Q_1 == 1:
            accumulator = add(accumulator, multiplicand)
            # print(f'accumulator2 = {accumulator}, multiplier2 = {multiplier}')
        
        product, Q_1 = right_shifting(multiplier, accumulator, Q_1, lsb_multiplier)
        accumulator = (product >> 32) & 0xFFFFFFFF
        multiplier = product & 0xFFFFFFFF
        # print(f'accumulator3 = {accumulator}, multiplier3 = {multiplier}')
        
        if ((multiplicand & 0x80000000) | (orgMultiplier & 0x80000000)) == 0x80000000:
            signed_result = to_signed_32bit(multiplier)
        else: 
            signed_result = multiplier
    return signed_result

def testBoothMultiply():
    test_cases = [
        [-146, -146, 21316],
        [-5, 3, -15],
        [5, -3, -15],
        [-5, -3, 15],
        [0, 5, 0],
        [5, 0, 0],
         [(2**31 - 1), 2, ((2**31-1)*2)],
        [2**31 - 1, 1, 2**31 - 1],
        [1, 2**31 - 1, 2**31 - 1],
        [-1, 2**31 - 1, -(2**31 - 1)],
        [1, -2**31, -2**31],
        [-1, -(2**31 - 1), 2**31 - 1]
    ]

    for multiplicand, multiplier, expected in test_cases:
        result = boothMultiplier(multiplicand, multiplier)
        print(f"Multiplicand: {multiplicand}, Multiplier: {multiplier}, Expected: {expected}, Result: {result}")
        if result != expected:
            print("Test case failed!")
        else:
            print("Test case passed.")

def main():
    testBoothMultiply()

if __name__ == "__main__":
    main()
