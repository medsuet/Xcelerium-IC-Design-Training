#!/usr/bin/env python

# booth multiplier 

import sys

# function to calculate twos complement
def twoscomplement(multiplicand):
    return (~multiplicand + 1)

# Right Arithmetic Shift
def rightArithmeticShift(accumulator, multiplier):
    # concatenate accumulator and multiplier
    # if multiplier is negative
    # type cast into unsigned number
    if (multiplier < 0):
        multiplier = multiplier + (1 << 32)
    result = (accumulator << 32 ) | multiplier
    result >>=1
    return result
    

# function to calculate multiplication of two signed numbers or integers
def boothMultiplier(multiplicand, multiplier):
    # initialize accumulator and multiplierLsb and incremented bit of multiplier
    accumultor = 0
    multiplierLsb = 0
    incrementedQBit = 0
    # for loop upto length of signed integer
    for i in range(32):
        # extracting lsb of multiplier
        multiplierLsb = multiplier & 1
        # if 10  accumulator - multiplicand
        if ((multiplierLsb == 1) & (incrementedQBit == 0)):
            result = twoscomplement(multiplicand)
            accumultor = accumultor + result
        # if 01 accumulator + multiplicand
        elif ((multiplierLsb == 0) & (incrementedQBit == 1)):
            accumultor = accumultor + multiplicand
            
        # arithmetic right shift
        # cancatenation of accumulator and multiplier
        product = rightArithmeticShift(accumultor, multiplier)
        # extract updated accumulator and multiplier
        accumultorUpdated = (rightArithmeticShift(accumultor, multiplier) >> 32)
        multiplierUpdated = rightArithmeticShift(accumultor, multiplier) & 0xFFFFFFFF
        # update accumulator and multiplier
        accumultor = accumultorUpdated
        multiplier = multiplierUpdated
        # print(f"A: {accumultor}\n Q: {multiplier}\n")
        incrementedQBit = multiplierLsb
        
    return product
        
        
        

print("The result is: ", boothMultiplier(-100, -10))
# integer size 

# my_int = 10
# print(f"Memory size of {my_int} = {sys.getsizeof(my_int)} bytes")
# print(sys.getsizeof(sys.maxsize))
# print(f"{my_int.bit_length()} ")