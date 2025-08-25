# -*- coding: utf-8 -*-
"""
Created on Mon Jul 15 10:25:15 2024

@author: Moazzam
"""

import random
import time
import numpy as np

RANGE = 1073741823

def right_shift_func(AC, Q, shift,):
    # Assuming int is 32 bits
    AC = np.int64(AC)
    #Q = np.uint32(Q)
    Q = np.array(Q).astype(np.uint32) 
    
    combined = (AC << 32) | Q
    combined = np.int64(combined)

    # Perform the circular right shift
    right_shifted = combined >> shift
    right_shifted = np.int64(right_shifted)
    # Split the combined number back into two integers
    AC = (right_shifted >> 32) 
    Q = right_shifted 

    AC = np.int32(AC)
    Q = np.uint32(Q)
    return AC, Q

def booth_mult(M, Q):
    # M = Multiplicand, Q = Multiplier

    Q_n = Q & 1  # for LSB for Q
    Q_n1 = 0
    SC = 32  # work like counter
    AC = 0

    while True:  # check cases
        if (Q_n == 0 and Q_n1 == 0) or (Q_n == 1 and Q_n1 == 1):
            AC, Q = right_shift_func(AC, Q, 1)
            SC -= 1
        elif Q_n == 1 and Q_n1 == 0:
            AC -= M
            AC, Q = right_shift_func(AC, Q, 1)
            SC -= 1
        elif Q_n == 0 and Q_n1 == 1:
            AC += M
            AC, Q = right_shift_func(AC, Q, 1)
            SC -= 1

        if SC == 0:
            break
        else:
            Q_n1 = Q_n
            Q_n = Q & 1

    product = (np.int64(AC) << 32) | np.uint32(Q)
    return product

def check_func(test_n):
    pass_count = 0
    copy_n = test_n
    while test_n:
        # Generate AC random number between -range and +range
        M = random.randint(-RANGE, RANGE)
        Q = random.randint(-RANGE, RANGE)
        booth_result = booth_mult(M, Q)
        simple_result = M * Q
        if booth_result == simple_result:
            pass_count += 1
        else:
            print("Booth Multiplication failed!")
            print(f"Booth Multiplier: AC {M} * Q {Q} = {booth_result}")
            print(f"Simple Multiplier: AC {M} * Q {Q} = {simple_result}")
            break
        test_n -= 1
    print(f"Total test: {copy_n}, Passed Test: {pass_count}")

def main():
    random.seed(time.time())
    multiplier   = int(input("Enter multiplier integer: "))
    multiplicant = int(input("Enter multiplicant integer: "))
    test_n =       int(input("Enter number of test for Booth_Multi.: "))

    print(f"The Product of {multiplier} and {multiplicant} is equal to {booth_mult(multiplicant, multiplier)}")
    check_func(test_n)

if __name__ == "__main__":
    main()
