import random
import time
import numpy as np

RANGE = (2**31 - 1)

def right_shift_func(AC, Q, shift):
    # Assuming int is 32 bits
    AC = np.int64(AC)
    #Convert Q to an unsigned 32 bit integer
    Q = np.array(Q).astype(np.uint32)

    # combined will be a 64 bit integer by default due to AC being used in it
    combined = (AC << 32) | Q
    # converting it into a numpy integer
    combined = np.int64(combined)

    # Perform the circular right shift
    combined = combined >> shift

    # Split the combined number back into two integers
    AC = (combined >> 32)
    Q = combined

    AC = np.int32(AC)
    Q = np.uint32(Q)
    return (AC,Q)

def booth_mult(M, Q):
    # M = Multiplicand, Q = Multiplier

    # Initialization
    Q_n = Q & 1    # LSB of Q
    Q_n1 = 0       # Q(n+1) - Initially zero
    SC = 32        # Counter
    AC = 0         # Accumulator

    while True:
        # Compare the value of Q_n and Q_n1
        if ((Q_n == 0) and (Q_n1 == 0)) or ((Q_n == 1) and (Q_n1 == 1)):    # Case 1: 00 or 11
            (AC, Q) = right_shift_func(AC, Q, 1)                            # Perform circular right shift
        elif (Q_n == 1) and (Q_n1 == 0):                                    # Case 2: 10
            AC = AC - M                                                     # AC = AC - M
            (AC, Q) = right_shift_func(AC, Q, 1)                            # Perform circular right shift
        elif (Q_n == 0) and (Q_n1 == 1):                                    # Case 3: 01
            AC = AC + M                                                     # AC = AC + M
            (AC, Q) = right_shift_func(AC, Q, 1)                            # Perform circular right shift

        SC -= 1    # Decrement in counter

        if (SC == 0):
            break      # End of loop

        Q_n1 = Q_n     # Q(n+1) will become Q(n)
        Q_n = Q & 1    # Q(n) will become LSB of Q

    # The answer will be in combined AC and Q
    product = (np.int64(AC) << 32) | np.uint32(Q)    # Combining AC and Q
    return product

def check_func(test_n):
    pass_count = 0
    fail_count = 0
    count = 0
    while (count != test_n):
        # Generate AC random number between -range and +range
        M = random.randint(-RANGE, RANGE)
        Q = random.randint(-RANGE, RANGE)
        booth_result = booth_mult(M, Q)
        simple_result = M * Q
        if booth_result == simple_result:
            pass_count += 1
            print(f"Test {count+1} passed!");
        else:
            print("Booth Multiplication failed!")
            print(f"Booth Multiplier: AC {M} * Q {Q} = {booth_result}")
            print(f"Simple Multiplier: AC {M} * Q {Q} = {simple_result}")
            fail_count += 1
        count+=1
    print(f"Total test: {test_n}, Passed Test: {pass_count}, Failed Test: {fail_count}")

def main():
    random.seed(time.time())
    #multiplier   = int(input("Enter multiplier: "))
    #multiplicant = int(input("Enter multiplicant: "))
    test_n =       int(input("Enter number of tests: "))

    #print(f"The Product of {multiplier} and {multiplicant} is equal to {booth_mult(multiplicant, multiplier)}")
    check_func(test_n)

if __name__ == "__main__":
    main()
