# -*- coding: utf-8 -*-
"""
Created on Mon Jul 15 12:44:20 2024

@author: Moazzam
"""

import random
import time

RANGE = 1073741823

def right_left_func(A, Q, shift,):
    combined = (A << 32) | (Q & 0xffffffff)
    combined = combined << 1
    A = (combined >> 32) & 0xffffffff
    Q = combined & 0xffffffff
    return (A, Q)

def non_restoring_division( Dividend, Divisior):
    #initialization
    M = Divisior & 0xffffffff
    Q = Dividend & 0xffffffff
    A = 0 & 0xffffffff
    n = 32

    if(M==0):
        print("Maths error")
        return (0,0)

    while(True):

        if( (A & 0x80000000) == 0 ):
            (A, Q)= right_left_func(A, Q, 1)
            A = (A-M) & 0xffffffff
        else:
            (A, Q) = right_left_func(A, Q, 1)
            A = (A+M) & 0xffffffff
        
        if( (A & 0x80000000) == 0 ):
            Q = Q | 0x00000001
        else:
            Q = Q & 0xfffffffe
        
        n -= 1
        if(n==0):
            break
        

    if( (A & 0x80000000) != 0 ):
        A = (A+M) & 0xffffffff
        
    Quotient = Q
    Remainder = A
    
    return (Quotient, Remainder)


def check_func(test_n):
    pass_count = 0
    copy_n = test_n
    while test_n:
        # Generate AC random number between -range and +range
        M = random.randint(0, RANGE)
        Q = random.randint(0, RANGE)
        non_restoring_division_result = non_restoring_division(M, Q)
        simple_q = M // Q
        simple_r = M % Q
        if non_restoring_division_result == (simple_q, simple_r):
            pass_count += 1
        else:
            print("Booth Multiplication failed!")
            print(f"Non-Restoriing division: AC {M} * Q {Q} = {non_restoring_division_result}")
            print(f"Simple division: AC {M} * Q {Q} = {simple_q},{simple_r}")
            break
        test_n -= 1
    print(f"Total test: {copy_n}, Passed Test: {pass_count}")




random.seed(time.time())
Dividend = int(input("Enter Dividend integer: "))
Divisior = int(input("Enter Divisior integer: "))
test_n   = int(input("Enter number of test for Booth_Multi.: "))

(q, r) = non_restoring_division( Dividend, Divisior)
print(f"The Product of {Dividend} and {Divisior} is equal to {q} and {r}")
check_func(test_n)

