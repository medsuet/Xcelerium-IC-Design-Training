def non_restoring_division(dividend: int, divisor: int) -> tuple[int, int]:
    """
    Perform division using the non-restoring division algorithm.

    Args:
        dividend (int): The value to be divided (32-bit unsigned integer).
        divisor (int): The value by which to divide (32-bit unsigned integer).

    Returns:
        tuple[int, int]: The quotient and remainder of the division.
    """
    # Ensure dividend and divisor are 32-bit unsigned integers
    dividend &= 0xFFFFFFFF
    divisor &= 0xFFFFFFFF

    # Handle edge cases
    if divisor == 0:
        return 0xFFFFFFFF, dividend  # Division by zero
    if dividend == 0:
        return 0, 0  # Division of zero by any non-zero divisor

    accumulator = 0       # Accumulator Register
    divisor_reg = divisor  # Divisor Register
    dividend_reg = dividend  # Dividend Register
    num_bits = 32         # Number of bits for the algorithm

    for _ in range(num_bits):
        # Left shift the accumulator and dividend registers
        combined = ((accumulator << 1) | ((dividend_reg & 0x80000000) >> 31)) & 0xFFFFFFFF
        dividend_reg = (dividend_reg << 1) & 0xFFFFFFFF
        dividend_reg |= (combined >> 31) & 1
        accumulator = combined & 0xFFFFFFFF

        # Subtract or add the divisor based on the sign of the accumulator
        if accumulator & 0x80000000 == 0:  # If accumulator is non-negative
            accumulator = (accumulator - divisor_reg) & 0xFFFFFFFF
        else:  # If accumulator is negative
            accumulator = (accumulator + divisor_reg) & 0xFFFFFFFF

        # Update the least significant bit of the dividend register
        if accumulator & 0x80000000 == 0:  # If accumulator is non-negative
            dividend_reg |= 1  # Set the LSB of dividend_reg to 1
        else:  # If accumulator is negative
            dividend_reg &= 0xFFFFFFFE  # Set the LSB of dividend_reg to 0

    # Final adjustment of the accumulator if it is negative
    if accumulator & 0x80000000:
        accumulator = (accumulator + divisor_reg) & 0xFFFFFFFF

    quotient = dividend_reg
    remainder = accumulator

    return quotient, remainder

# Test cases
test_cases = [
    (4, 2),    # Expected quotient: 2, remainder: 0
    (10, 3),   # Expected quotient: 3, remainder: 1
    (15, 5),   # Expected quotient: 3, remainder: 0
    (100, 7),  # Expected quotient: 14, remainder: 2
    (25, 4),   # Expected quotient: 6, remainder: 1
    (30, 6),   # Expected quotient: 5, remainder: 0
    (0, 2),    # Expected quotient: 0, remainder: 0
]

# Evaluation
for dividend, divisor in test_cases:
    quotient, remainder = non_restoring_division(dividend, divisor)
    expected_quotient = dividend // divisor if divisor != 0 else 0xFFFFFFFF
    expected_remainder = dividend % divisor if divisor != 0 else dividend

    # Check if the quotient and remainder match expected values
    if quotient == expected_quotient and remainder == expected_remainder:
        print("Test Passed!")
        print(f"Dividend: {dividend}, Divisor: {divisor}")
        print(f"Expected Quotient: {expected_quotient}, Expected Remainder: {expected_remainder}")
        print(f"Computed Quotient: {quotient}, Computed Remainder: {remainder}\n")
    else:
        print("Test Failed!")
        print(f"Dividend: {dividend}, Divisor: {divisor}")
        print(f"Expected Quotient: {expected_quotient}, Expected Remainder: {expected_remainder}")
        print(f"Computed Quotient: {quotient}, Computed Remainder: {remainder}\n")
