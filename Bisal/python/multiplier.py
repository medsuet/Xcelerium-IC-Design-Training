'''*
 * ============================================================================
 * Filename:    sequential_multiplier.c 
 * Description: File consists of maze generator and path navigation codes
 * Author:      Bisal Saeed
 * Date:        7/18/2024
 * ============================================================================
 '''

import random

def twosComplement(M,n):
    #flip all bits -> 1's compliment
    M = ~M & 0xF    
    # add 1 -> 2's compliment
    M = (M + 1) & 0xF   
    
    return M 

def shiftValue(A, Q, q1, n):
    bitsA=4
    signBitA= (A >> (bitsA-1)) & 1
    q1 = Q & 1
    lsbA = A & 1
    
    A = (A>>1) | (signBitA << (bitsA-1))
    
    # Shift Q to the right by 1 bit, with the LSB of A becoming the MSB of Q
    Q = (Q >> 1) | (lsbA << (n - 1))
    
    return A & 0x0F, Q, q1


def combineBits(A, Q, n):
    #shifted_a= A << n;
    prod = (A << n) | Q;
    return prod


def sequenceMultiplier(multiplicand,multiplier):
    # testing condition
    if (multiplicand<0 and multiplier>0 ) or (multiplicand>0 and multiplier<0):
        flag=1
    else:
        flag=0
    
    # deal with negative values 
    acc= 0 & 0xffffffff;
    M = (-multiplicand & 0xffffffff) if multiplicand < 0 else (multiplicand) & 0xffffffff
    Q = -multiplier if multiplier < 0 else multiplier
    q1 = 0      #LSB of Q 
    #check for debugging
    print(f"Binary representation of accumulator (acc) : {bin(acc)}")
    print(f"Binary representation of multiplicand (M): {bin(M)}")
    print(f"Binary representation of multiplier (Q): {bin(Q)}")
    print(f"Binary representation of Q1: {q1}\n")
    count = 4
    counter=count
    mBits= 4

    while counter > 0 :
        lsb_q = Q & 1 
        # 01 CASE
        if (q1 == 1 and lsb_q == 0): 
            # A <- A + M
            acc = (acc + M )& 0xF
            print(f"Binary representation of accumulator after addition: {bin(acc)}")

        # 10 CASE
        elif (q1 == 0 and lsb_q == 1): 
            # A <- A - M 
            negM= twosComplement(M,mBits)
            acc = (acc + negM) & 0xF
            print(f"Binary representation of accumulator after addition: {bin(A)}")

        acc, Q, q1 = shiftValue(acc, Q, q1, count)
        print(bin(acc),bin(Q),bin(q1))
        
        counter = counter-1

     # find product by combining A and Q
    product = combineBits(acc,Q,count)
    if ( flag == 1 ):
        product=-product
    else: 
        product=product
    print(f"Binary representation of product is : {product}, {bin(product)}\n")
    return product

def main():
    for i in range(5):
        num1=random.randint(-5,5)
        num2=random.randint(-5,5)
        print(f"Enter the first number: {num1}")
        print(f"Enter the second number: {num2}")

        #num1=3
        #num2=-7
        originalResult=num1*num2;
        print(f"The original result is : {originalResult} ,{bin(originalResult)}\n")

        resultByMultiplier=sequenceMultiplier(num1, num2)

        # check if result by multiplier is equal to result by simple multiplication

        if (bin(originalResult)==bin(resultByMultiplier)):
            print("PASSED\n")
        else:
            print("FAILED\n")


if __name__ == "__main__":
    main()