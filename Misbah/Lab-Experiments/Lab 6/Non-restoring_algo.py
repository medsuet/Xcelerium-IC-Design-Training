"""
* File: Non-restoring_algo.py
* Author: Misbah Rani
* Date: 2024-07-20
* Description: This file contains the implementation of Non-Restoring Division Algorithm for 32 bit numbers.
*            
*
"""
def dec_to_bin(n, bits):
    return bin(n & int("1" * bits, 2))[2:].zfill(bits)

def non_restoring_division(dividend, divisor):
    quotient = 0
    remainder = 0
    bits = 32

    
    for i in range(bits):
        remainder = (remainder << 1) | ((dividend >> (bits - 1 - i)) & 1)

       
        if remainder >= divisor:
            remainder -= divisor
            quotient = (quotient << 1) | 1
        else:
            quotient = quotient << 1

    return quotient, remainder

def main():
    
    dividend = int(input("Enter the 32 bit dividend: "))
    divisor = int(input("Enter the 32 bit divisor: "))
    if dividend < 0 or dividend >= 2**32 or divisor <= 0 or divisor >= 2**32:
        print("Inputs must be 32-bit unsigned integers.")
        return

    quotient, remainder = non_restoring_division(dividend, divisor)

    print(f"The quotient in binary is: {dec_to_bin(quotient, 32)}")
    print(f"The remainder in binary is: {dec_to_bin(remainder, 32)}")
    print(f"The quotient in decimal is: {quotient}")
    print(f"The remainder in decimal is: {remainder}")

main()
