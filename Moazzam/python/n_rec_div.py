# -*- coding: utf-8 -*-
"""
Created on Mon Jul 15 12:44:20 2024

@author: Moazzam
"""
import numpy as np

"""
def right_left_func(A, Q, shift,):
    # Assuming int is 32 bits
    A = np.uint32(A)
    Q = np.uint32(Q)
    #A =  np.array(A).astype(np.uint64) 
    #Q =   np.array(Q).astype(np.uint32) 
    A_s = A << 32
    A_s = np.int64(A_s)
    combined = A_s | Q
    combined = np.int64(combined)

    # Perform the circular right shift
    left_shifted = combined << shift
    left_shifted = np.uint64(left_shifted)
    # Split the combined number bak into two integers
    A = (left_shifted >> 32) 
    Q = left_shifted 

    A = np.int32(A)
    Q = np.uint32(Q)
    return A, Q


def right_left_func(A, Q, shift):
    # Ensure A and Q are 32-bit and 64-bit unsigned integers
    #A = np.uint64(A)
    Q = np.uint32(Q)
    
    # Combine A and Q into a single 64-bit unsigned integer
    aaa = np.left_shift(np.int64(A), 32)
    combined = aaa | Q

    combined = np.uint64(combined)

    # Perform the circular right shift
    right_shifted = combined >> shift
    

    # Split the combined number back into two integers
    A = (right_shifted >> 32) & np.uint64(0xFFFFFFFF)
    Q = right_shifted & np.uint64(0xFFFFFFFF)

    # Convert back to the desired types
    A = np.int32(A)
    Q = np.uint32(Q)
    return A, Q
"""

def right_left_func(A, Q, shift,):
    A = np.uint32(A)
    Q = np.uint32(Q)
    q_d = Q
    Q = Q << 1
    A = A << 1
    A = A & (q_d>>31)
    A = np.uint32(A)
    Q = np.uint32(Q)
    return A, Q

def non_restoring_division( Dividend, Divisior):
    #initialization
    M = Divisior
    Q = Dividend
    A = 0 
    n = Q.bit_length()

    while(True):
        if( (A>>31) == 0 ):
            #A = np.uint64(A)
            #Q = np.uint32(Q)
            A, Q = right_left_func(A, Q, 1)
            A = A-M
        else:
            #A = np.uint64(A)
            #Q = np.uint32(Q)
            A, Q = right_left_func(A, Q, 1)
            A = A+M
        
        if( (A>>31) == 0 ):
            Q = np.uint32(Q) | 0x00000001
        else:
            Q = np.uint32(Q) & 0xfffffffe
        
        n -= 1
        
        if(n==0):
            break
        
    if( (A>>31) != 0 ):
        A = A+M
        
    Quotient = Q
    Remainder = A
    
    return Quotient, Remainder
                

def main():
    #random.seed(time.time())
    Dividend   = 15 #int(input("Enter Dividend integer: "))
    Divisior =  7 #int(input("Enter Divisior integer: "))
    #test_n =       int(input("Enter number of test for Booth_Multi.: "))
    
    q, r = non_restoring_division( Dividend, Divisior)

    print(f"The Product of {Dividend} and {Divisior} is equal to {q} and {r}")
    #check_func(test_n)

if __name__ == "__main__":
    main()
