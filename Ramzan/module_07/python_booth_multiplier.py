import numpy as np

def right_shift_func(num1, num2, my_shift):
    # Perform the circular right shift
    right_shift = (np.int64(num1) << 32) | np.uint32(num2)
    right_shift = np.int64(right_shift) >> my_shift

    # Split the combined number back into two integers
    num1 = np.int32(right_shift >> 32)
    num2 = np.uint32(right_shift)

    return num1, num2

def booth_mult(M, Q):
    Q_n = Q & 1  # LSB of Q
    Q_n1 = 0
    SC = 32  # bit size of Q
    AC = 0

    while SC > 0:
        if (Q_n == 0 and Q_n1 == 0) or (Q_n == 1 and Q_n1 == 1):
            AC, Q = right_shift_func(AC, Q, 1)
            SC = SC - 1
        elif Q_n == 1 and Q_n1 == 0:
            AC = AC - M
            AC, Q = right_shift_func(AC, Q, 1)
            SC = SC - 1
        elif Q_n == 0 and Q_n1 == 1:
            AC = AC + M
            AC, Q = right_shift_func(AC, Q, 1)
            SC = SC - 1

        Q_n1 = Q_n
        Q_n = Q & 1

    product = (np.int64(AC) << 32) | np.uint32(Q)
    return product

def main():
    multiplier = np.int32(input("Enter a multiplier Integer: "))
    multiplicand = np.int32(input("Enter a multiplicand Integer: "))

    product = booth_mult(multiplicand, multiplier)

    print(f"The Product of {multiplier} and {multiplicand} is equal to {product}")

if __name__ == "__main__":
    main()
