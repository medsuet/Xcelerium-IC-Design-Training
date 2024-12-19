def arithmetic_right_shift(accumulator, multiplier, qn_1):
    """
    Perform an arithmetic right shift on the combined value of the accumulator,
    multiplier, and Qn-1.

    Args:
        accumulator (int): The accumulator register.
        multiplier (int): The multiplier register (Q).
        qn_1 (int): The Qn-1 register.

    Returns:
        tuple: Updated values of the accumulator, multiplier, and Qn-1.
    """
    # Combine the accumulator, multiplier, and Qn-1 into a single 64-bit value
    combined = ((accumulator & 0xFFFFFFFFFFFFFFFF) << 33) | \
               ((multiplier & 0xFFFFFFFF) << 1) | \
               (qn_1 & 0x1)
    
    # Arithmetic right shift
    combined >>= 1

    # Extract the new values of accumulator, multiplier, and Qn-1
    qn_1 = combined & 0x1
    multiplier = (combined >> 1) & 0xFFFFFFFF
    accumulator = (combined >> 33) & 0xFFFFFFFFFFFFFFFF

    return accumulator, multiplier, qn_1

def booth_multiplier(multiplicand, multiplier):
    """
    Perform multiplication using Booth's algorithm.

    Args:
        multiplicand (int): The multiplicand.
        multiplier (int): The multiplier.

    Returns:
        int: The result of the multiplication.
    """
    # Ensure that multiplicand and multiplier are 32-bit numbers
    multiplicand &= 0xFFFFFFFF
    multiplier &= 0xFFFFFFFF

    # Convert to two's complement for negative values
    if multiplicand & 0x80000000:
        multiplicand -= 0x100000000

    if multiplier & 0x80000000:
        multiplier -= 0x100000000

    # Initialize registers
    accumulator = 0           # Accumulator Register
    q = multiplier            # Multiplier Register (Q)
    qn_1 = 0                  # Qn+1 Register
    m = multiplicand          # Multiplicand Register
    num_bits = 32             # Number of bits

    # Booth's algorithm loop
    for _ in range(num_bits):
        qn = q & 1  # Extract the least significant bit of Q
        
        # Case when Qn and Qn+1 = 01
        if qn == 0 and qn_1 == 1:
            accumulator = (accumulator + m) & 0xFFFFFFFFFFFFFFFF

        # Case when Qn and Qn+1 = 10
        elif qn == 1 and qn_1 == 0:
            accumulator = (accumulator - m) & 0xFFFFFFFFFFFFFFFF

        # Perform the arithmetic right shift
        accumulator, q, qn_1 = arithmetic_right_shift(accumulator, q, qn_1)

    # Combine the accumulator and multiplier for the final result
    result = ((accumulator << 32) | (q & 0xFFFFFFFF)) & 0xFFFFFFFFFFFFFFFF

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

    # Check if the Booth's algorithm result matches the expected result
    if booth_result == standard_result:
        print("Test Passed!")
        print(f"Multiplicand: {multiplicand}, Multiplier: {multiplier}")
        print(f"Expected Result: {standard_result}, Booth Result: {booth_result}")
    else:
        print("Test Failed!")
        print(f"Multiplicand: {multiplicand}, Multiplier: {multiplier}")
        print(f"Expected Result: {standard_result}, Booth Result: {booth_result}")
