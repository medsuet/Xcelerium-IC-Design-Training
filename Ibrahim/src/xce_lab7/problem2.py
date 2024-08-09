import random

def non_restoring_division(dividend, divisor):
    # Constants
    BITS_IN_UINT32 = 32

    # Initialize registers
    Q = dividend        # Dividend
    M = divisor         # Divisor
    A = 0               # Accumulator
    n = BITS_IN_UINT32  # Number of bits

    # Handle division by zero
    if divisor == 0:
        print("Error: Division by zero.")
        return 0, 0

    # Initialize quotient and remainder
    quotient = 0
    remainder = 0

    while n != 0:
        if A & 0x80000000:  # If MSB of A is 1
            # Left shift AQ
            combinedAQ = (A << 32) | Q
            combinedAQ = (combinedAQ << 1)
            Q = combinedAQ & 0xFFFFFFFF
            A = (combinedAQ >> 32) & 0xFFFFFFFF
            
            # Add M to A
            A += M
        else:
            # Left shift AQ
            combinedAQ = (A << 32) | Q
            combinedAQ = (combinedAQ << 1)
            Q = combinedAQ & 0xFFFFFFFF
            A = (combinedAQ >> 32) & 0xFFFFFFFF
            
            # Subtract M from A
            A -= M

        if A & 0x80000000:  # If MSB of A is 1
            # Set lsb of Q to 0
            Q &= 0xFFFFFFFE
        else:
            # Set lsb of Q to 1
            Q |= 1
        
        n -= 1

    if A & 0x80000000:  # If MSB of A is 1
        # Add M to A
        A += M

    # Finally, the register Q contains the quotient and A contains remainder
    quotient = Q
    remainder = A

    return quotient, (remainder & 0xFFFFFFFF)

def run_test_case(dividend, divisor):
    # Call non_restoring_division
    quotient, remainder = non_restoring_division(dividend, divisor)

    # Compare with standard division
    actualQ = dividend // divisor
    actualR = dividend % divisor

    # Print both the restored values and actual values
    print("Test Case:")
    print(f"Dividend: {dividend}, Divisor: {divisor}")
    print(f"Restored Quotient: {quotient}, Restored Remainder: {remainder}")
    print(f"Operator Quotient: {actualQ}, Operator Remainder: {actualR}")

    # Validate results
    if quotient == actualQ and remainder == actualR:
        print("Results match!\n")
    else:
        print("Results do not match.\n")


def main():
   
    # Implement multiple test cases
    for _ in range(10):
        # Random dividend and divisor
        dividend = random.randint(0, 10000)
        divisor = random.randint(1, 10000)  # Ensure divisor is not zero

        # Call the test function
        run_test_case(dividend, divisor)

if __name__ == "__main__":
    main()
