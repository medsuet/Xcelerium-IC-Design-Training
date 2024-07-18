def arithmetic_right_shift(AC, Q, Qn_1):
    combined = ((AC & 0xFFFFFFFFFFFFFFFF) << 33) | ((Q & 0xFFFFFFFF) << 1) | (Qn_1 & 0x1)
    combined >>= 1
    Qn_1 = combined & 0x1
    Q = (combined >> 1) & 0xFFFFFFFF
    AC = (combined >> 33) & 0xFFFFFFFFFFFFFFFF
    return AC, Q, Qn_1

def booth_multiplier(multiplicand, multiplier):
    # Ensure that multiplicand and multiplier are 32-bit numbers
    multiplicand &= 0xFFFFFFFF
    multiplier &= 0xFFFFFFFF

    # Convert to two's complement for negative values
    if multiplicand & 0x80000000:
        multiplicand = -(0x100000000 - multiplicand)
    if multiplier & 0x80000000:
        multiplier = -(0x100000000 - multiplier)

    # Initializing the registers
    AC = 0                 # Accumulator Register
    Q = multiplier         # Multiplier Register (Q)
    Qn_1 = 0               # Qn+1 Register
    M = multiplicand       # Multiplicand Register
    n = 32                 # Number of bits

    for _ in range(n):     # For loop that runs 32 times
        Qn = Q & 1         # Qn = last bit of Q 
        
        # Case when Qn and Qn+1 = 01
        if (Qn == 0) and (Qn_1 == 1):
            AC = (AC + M) & 0xFFFFFFFFFFFFFFFF  # AC = AC + Multiplicand

        # Case when Qn and Qn+1 = 10
        elif (Qn == 1) and (Qn_1 == 0):
            AC = (AC - M) & 0xFFFFFFFFFFFFFFFF  # AC = AC - Multiplicand

        # Perform the arithmetic right shift
        AC, Q, Qn_1 = arithmetic_right_shift(AC, Q, Qn_1)

    # Combine AC and Q for the final result
    result = ((AC << 32) | (Q & 0xFFFFFFFF)) & 0xFFFFFFFFFFFFFFFF

    # Convert the result to a signed 64-bit integer
    if result & 0x8000000000000000:
        result -= 0x10000000000000000

    return result

# Testing with various combinations
test_cases = [
    (2, -2147483647),
    (-2648768, 4),
    (-2, -4),
    (7, -3),
    (-7, 3),
    (-7, -3)
]

for multiplicand, multiplier in test_cases:
    booth_result = booth_multiplier(multiplicand, multiplier)
    standard_result = multiplicand * multiplier

    # Check if the multiplier and the standard result are the same:
    if booth_result == standard_result:
        print("Test Passed!")
        print(f"Multiplicand: {multiplicand}, Multiplier: {multiplier}")
        print(f"Expected Result: {standard_result}, Booth Result: {booth_result}")
    else:
        print("Test Failed!")
        print(f"Multiplicand: {multiplicand}, Multiplier: {multiplier}")
        print(f"Expected Result: {standard_result}, Booth Result: {booth_result}")
