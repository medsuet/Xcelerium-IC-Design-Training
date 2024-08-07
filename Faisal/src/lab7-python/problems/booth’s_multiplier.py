def complement(multiplicand):
    return (~multiplicand) + 1

def arithmetic_right_shift(multiplier, accumulator):
    if (multiplier < 0):
        multiplier = multiplier + (1<<32)
    value = (accumulator << 32) | multiplier
    value = value >> 1
    return value

def booth_multiplier(multiplier, multiplicand):
    num_bits = 32  # Assuming 32-bit operations
    Qn = 0 # Qn+1
    accumulator = 0
    
    for i in range(num_bits - 1):
        multiplier_lsb = multiplier & 1 # Qn
        
        if multiplier_lsb == 0 and Qn == 1:
            accumulator = accumulator + multiplicand
        elif multiplier_lsb == 1 and Qn == 0:
            accumulator = accumulator + complement(multiplicand)
        
        Qn = multiplier_lsb
        accumulator_shifted = arithmetic_right_shift(multiplier, accumulator)
        multiplier = accumulator_shifted & ((1 << 32) - 1)
        accumulator = arithmetic_right_shift(multiplier, accumulator) >> 32
      
    
    return arithmetic_right_shift(multiplier, accumulator)

# Test the function with given example
multiplier = 15
multiplicand = 6

print(f"Multiplier: {multiplier}, Multiplicand: {multiplicand}")
result = booth_multiplier(multiplier, multiplicand)
expected = multiplier * multiplicand
print(f"Result: {result}")

if result == expected:
    print(f"Actual Result {result} and Expected Result {expected} Test Pass")
else:
    print(f"Actual Result {result} and Expected Result {expected} Test Fail")
