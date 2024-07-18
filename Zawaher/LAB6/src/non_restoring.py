def non_restoring(dividend, divisor):
    # Ensure that the dividend and the divisor are 32-bit numbers
    dividend &= 0xFFFFFFFF
    divisor &= 0xFFFFFFFF

    # Checks if the dividend is zero
    if dividend == 0:
        quotient = 0
        remainder = 0
        return quotient, remainder
    
    # Checks if the divisor is zero
    elif divisor == 0:
        quotient = 0xFFFFFFFF
        remainder = 0xFFFFFFFF
        return quotient, remainder

    Acc = 0             # Accumulator Register
    M = divisor         # Divisor Register
    Q = dividend        # Dividend Register
    n = 32              # Count to 32

    for _ in range(n):
        # Left Shift AQ as a single unit 
        combined = ((Acc << 1) | ((Q & 0x80000000) >> 31)) & 0xFFFFFFFF
        Q = (Q << 1) & 0xFFFFFFFF
        Q |= (combined >> 31) & 1
        Acc = combined & 0xFFFFFFFF

        # Subtract M if Acc is non-negative; add M if Acc is negative
        if Acc & 0x80000000 == 0:  # Acc is non-negative
            Acc = (Acc - M) & 0xFFFFFFFF
        else:  # Acc is negative
            Acc = (Acc + M) & 0xFFFFFFFF

        # Update Q based on the result of the arithmetic operation
        if Acc & 0x80000000 == 0:  # Acc is non-negative
            Q |= 1  # Set the LSB of Q to 1
        else:  # Acc is negative
            Q &= 0xFFFFFFFE  # Set the LSB of Q to 0

    # If Acc is negative at the end, add M to it
    if Acc & 0x80000000:
        Acc = (Acc + M) & 0xFFFFFFFF

    quotient = Q
    remainder = Acc

    return quotient, remainder

# Test cases
test_cases = [
    (4, 2),    # Expected quotient: 2, remainder: 0
    (10, 3),   # Expected quotient: 3, remainder: 1
    (15, 5),   # Expected quotient: 3, remainder: 0
    (100, 7),  # Expected quotient: 14, remainder: 2
    (25, 4),   # Expected quotient: 6, remainder: 1
    (30, 6),   # Expected quotient: 5, remainder: 0
    (0, 2),    # Division by zero case
]

# Evaluation
for dividend, divisor in test_cases:
    quotient, remainder = non_restoring(dividend, divisor)
    expected_quotient = dividend // divisor if divisor != 0 else 0xFFFFFFFF
    expected_remainder = dividend % divisor if divisor != 0 else dividend

    # Check if the quotient and remainder match expected values
    if quotient == expected_quotient and remainder == expected_remainder:
        print(f"Test Passed!")
        print(f"Dividend: {dividend}, Divisor: {divisor}")
        print(f"Expected Quotient: {expected_quotient}, Expected Remainder: {expected_remainder}")
        print(f"Computed Quotient: {quotient}, Computed Remainder: {remainder}\n")
    else:
        print(f"Test Failed!")
        print(f"Dividend: {dividend}, Divisor: {divisor}")
        print(f"Expected Quotient: {expected_quotient}, Expected Remainder: {expected_remainder}")
        print(f"Computed Quotient: {quotient}, Computed Remainder: {remainder}\n")
