
"""
============================================================================
 * Filename:   Division.py
 * Description: Contain the implementation of Restoring division
                using bitwise operations
 * Author:      Hira Firdous
 * Date:        19/07/2024
 * ===========================================================================

"""


from random import randint
def print_binary(num, bit_width):
    """
    :param num: integer value you want to print
    :param bit_width: bit width of number(can be calculated with num.bit_length())
    :return: prints binary of number upto given bit width
    """
    print(format(num, f'0{bit_width}b'))

def arithmeticleftshift(A, Q, bit_width):
    """
    :param A: value in accomulator
    :param Q: value in Q
    :param bit_width: value in bit_width
    :return: 
    """
    MSB_Q = (Q >> (bit_width-1)) & 1  # Get the MSB of Q
    print("MSB OF Q ",MSB_Q)
    # Shift A left and update its LSB with MSB of Q
    A = (A << 1) | MSB_Q
    # Shift Q left
    Q = (Q << 1)
    return A, Q


def restoring_division(dividend, divisor):
    """
    Perform restoring division using given dividend and divisor.
    """
    if dividend == 0 and divisor == 0:
        remainder = 0
        quotient = 0
        return remainder, quotient

    # Variables initialization and declaration
    MSB_A = 0
    N = dividend.bit_length()
    width = dividend.bit_length()
    A = 0
    M = divisor
    Q = dividend
    temp_A = A

    while N > 0:

        temp_A = A  # for restoring purpose
        A = A - M
        MSB_A = (A >> (width - 1)) & 1

        if MSB_A == 0:
            Q = Q | 1  # LSB_Q=1
        else:
            A = temp_A  # Restore A

        N = N - 1
    quotient = Q & ((1 << (dividend.bit_length() - 1)) - 1)  # Mask Q to width-1 bits to get the correct quotient
    remainder = A  # A now holds the remainder

    return remainder, quotient


def testing_by_random_testcases():
    """
    Run random test cases on it.
    NOTE: Working fine for some test_cases
          -But Still there is room to fix
    """

    test_cases = 0;

    test_cases=input("Enter the number of test cases you want to run:\n")
    test_cases=int(test_cases)
    """"""
    for i in range (0,test_cases):
        input_number_1=randint(0,(2^31));
        input_number_2=randint(0,(2^31));

        #output from my function
        rd_remainder, rd_quotient=restoring_division(input_number_1, input_number_2);

        #output from operator
        quotient=input_number_1 // input_number_2;
        remainder=input_number_1 %  input_number_2

        print("Test case", i + 1, ":");
        print(input_number_1,"/", input_number_2 );
        print(rd_remainder,remainder )
        print(rd_quotient,quotient )
        if ( (rd_remainder == remainder) and (rd_quotient == quotient)):
            print("Passes")
        else:
            print("Failed")

def main():
    #Sample testing:

        # Test case
        dividend = 10
        divisor = 2
        remainder, quotient = restoring_division(dividend, divisor)
        print(f"Remainder: {remainder}, Quotient: {quotient}")

    #testing_by_random_testcases()



if __name__ == "__main__":
    main()
