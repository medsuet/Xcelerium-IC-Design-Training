
"""
============================================================================
 * Filename:    Multiplier.py
 * Description: Contain the implementation using bitwise operations
 * Author:      Hira Firdous
 * Date:        17/07/2024
 * ===========================================================================

"""


from random import random, randint
def print_binary(num,bit_width):
    """
    :param num: integer value you want to print
    :param bit_width: bit width of number(can be calculated with num.bit_length())
    :return: prints binary of number upto given bit width
    """
    print(format(num, f'0{bit_width}b'))

def combineBits(A, Q, bit_width):
    """
    :param A: integer A
    :param Q: integer Q
    :param bit_width:  bit width of number(can be calculated with num.bit_length())
    :return: combined answer-> AQ
    """
    LSB_A = A << bit_width
    combined = LSB_A | Q
    return combined

def arithmetic_shift(A,Q,bit_width):
    """
    :param A: integer A
    :param Q: integer Q
    :param bit_width: upto which we want to shift
    :return: perform arithmetic shift on A,Q and updated value of Q
    """
    sign_bit_A=A >> (bit_width) & 1
    lsb_A = A & 1
    lsb_Q = Q & 1
    Q_minus = lsb_Q

    # Shift Q right and update its MSB with LSB of A
    Q = (Q >> 1) | (lsb_A << (bit_width - 1))

    #Shift A right and preserve its sign bit
    A = (A >> 1) | (sign_bit_A << (bit_width - 1))
    return A,Q,Q_minus



def booth_multiplication(multiplicand, multiplier):
    """
    :param multiplicand: first operand
    :param multiplier:   second operand
    :return:  return product of operands
    """
    if multiplier == 0 or multiplicand == 0:
        return 0

    A = 0
    Q = abs(multiplier)
    M = abs(multiplicand)
    Q_minus_1 = 0
    width = max(multiplicand.bit_length(), multiplier.bit_length()) + 1

    for i in range(width):
        lsb_Q = Q & 1
        operation_code = (Q_minus_1 << 1) | lsb_Q

        if operation_code == 2:  # Q_minus_1 = 1, lsb_Q = 0 -> Add M to A
            A = A + M
        elif operation_code == 1:  # Q_minus_1 = 0, lsb_Q = 1 -> Subtract M from A
            A = A - M

        A, Q, Q_minus_1 = arithmetic_shift(A, Q, width)

    combined = combineBits(A, Q, width)

    if (multiplier < 0 and multiplicand >= 0) or (multiplier >= 0 and multiplicand < 0):
        combined = -combined

    return combined

"""
# Test cases
print(booth_multiplication(6, 6))  # 36
print(booth_multiplication(7, 7))  # 49
print(booth_multiplication(-6, 6))  # -36
print(booth_multiplication(-7, -7))  # 49
print(booth_multiplication(0, 7))  # 0
print(booth_multiplication(11, 14))  # 0

"""

def testing_by_random_testcases():

    test_cases = 0;

    test_cases=input("Enter the number of test cases you want to run:\n")
    test_cases=int(test_cases)
    """"""
    for i in range (0,test_cases):
        input_number_1=randint(0,(2^31));
        input_number_2=randint(0,(2^31));

        #output from my function
        booth_answer=booth_multiplication(input_number_1, input_number_2);
        #output from operator
        original_answer=(input_number_1) * input_number_2;
        print("Test case", i + 1, ":\n");
        print(input_number_1,"x", input_number_2 ,"\n");
        if (booth_answer == original_answer):
            print("Passed\n")
        else:
            print("Failed\n")

testing_by_random_testcases()








