def booth_algorithm(multiplicand, multiplier):
    def arithmetic_right_shift(ac, q, qn):
        combined = (ac << 33) | (q << 1) | qn
        combined >>= 1
        ac = (combined >> 33) & 0xFFFFFFFF
        q = (combined >> 1) & 0xFFFFFFFF
        qn = combined & 1
        return ac, q, qn

    # Handle negative multiplicands and multipliers
    multiplicand_neg = multiplicand < 0
    multiplier_neg = multiplier < 0
    multiplicand = abs(multiplicand)
    multiplier = abs(multiplier)

    ac = 0
    q = multiplier
    qn = 0
    sc = 32

    # Two's complement of multiplicand for subtraction
    neg_multiplicand = (~multiplicand + 1) & 0xFFFFFFFF

    print(f"Initial Values: AC={ac}, Q={q}, Qn+1={qn}, M={multiplicand}, M'={neg_multiplicand}")

    # Booth's Algorithm
    while sc > 0:
        if (q & 1) == 0 and qn == 1:
            ac = (ac + multiplicand) & 0xFFFFFFFF
            print(f"Add M: AC={ac}")
        elif (q & 1) == 1 and qn == 0:
            ac = (ac + neg_multiplicand) & 0xFFFFFFFF
            print(f"Subtract M': AC={ac}")
        ac, q, qn = arithmetic_right_shift(ac, q, qn)
        print(f"Shift Right: AC={ac}, Q={q}, Qn+1={qn}")
        sc -= 1

    # Combine AC and Q for final result
    result = (ac << 32) | q

    # Adjust the result to be signed
    if multiplicand_neg ^ multiplier_neg:
        result = (~result + 1) #& 0xFFFFFFFFFFFFFFFF
        return -q
    return q

# Example Usage
multiplicand = -100
multiplier = 4
product = booth_algorithm(multiplicand, multiplier)
print(f"The product of {multiplicand} and {multiplier} is {product}")

