'''*
 * ============================================================================
 * Filename:    sequential_multiplier.c 
 * Description: File consists of maze generator and path navigation codes
 * Author:      Bisal Saeed
 * Date:        7/18/2024
 * ============================================================================
 '''

def twosComplement(M,n):
    #flip all bits -> 1's compliment
    M = ~M & 0xF    
    # add 1 -> 2's compliment
    M = (M + 1) & 0xF   
    
    return M 

def shiftValue(A, Q, q1, n): #CHANGE 
    bitsA=4
    signBitA= (A >> (bitsA-1)) & 1
    q1 = Q & 1
    lsbA = A & 1
    
    A = (A>>1) | (signBitA << (bitsA-1))
    
    # Shift Q to the right by 1 bit, with the LSB of A becoming the MSB of Q
    Q = (Q >> 1) | (lsbA << (n - 1))
    
    return A & 0x0F, Q, q1


def sequenceDivision(dividend,divisor):
        # for neg * pos values
    if (dividend<0 and divisor>0 ) or (dividend>0 and divisor<0):
        flag=0
    elif (dividend ==0 or divisor ==0) :
        flag=1
    else:
        flag=2
    
    # deal with negative values 
    acc= 0 & 0xffffffff;
    M = (-dividend & 0xffffffff) if dividend < 0 else (dividend) & 0xffffffff
    Q = -divisor if divisor < 0 else divisor
    q1 = 0      #LSB of Q 
    print(f"Binary representation of accumulator: {bin(acc)}")
    print(f"Binary representation of M: {bin(M)}")
    print(f"Binary representation of Q: {bin(Q)}")
    print(f"Binary representation of Q1: {q1}\n")
    count = 4
    counter=count
    mBits= 4

    while counter > 0 :
        #shift AQ
        acc, Q, q1 = shiftValue(acc, Q, q1, count)
        print(bin(acc),bin(Q),bin(q1))


        #lsb of Q 
        lsbQ = Q & 1
        tempA = acc # temporary variable for restoring A
        #A <- A-M
        negM= twosComplement(M,mBits)
        acc = (acc + negM) & 0xF

        #Get MSB of accumulator
        bitsA=4
        signBitA= (acc >> (bitsA-1)) & 1 

        # 0 CASE
        if ( signBitA == 0): 
            lsbQ=1
            Q = Q | lsbQ
            

        # 1 CASE
        elif ( signBitA == 1 ): 
            lsbQ=0
            Q = Q | lsbQ
            acc = tempA

        counter = counter-1

     # find quotient by combining A and Q
    quotient = Q
    remainder = acc

    #testing conditions
    if(flag ==0):
        quotient=-quotient
        remainder=-remainder
    elif ( flag == 1 ):
        quotient=0
        remainder=0
    elif (flag == 2): 
        quotient=quotient
        remainder=remainder

    print(f"Binary representation of quotient is: {quotient}, {bin(quotient)}\n")
    print(f"Binary representation of quotient is: {remainder}, {bin(remainder)}\n")

    return quotient,remainder



def main():

        num1=11
        num2=3
        originalQuotient=num1//num2
        originalRemainder=num1%num2

        print(f"The original quotient is : {originalQuotient} ,{bin(originalQuotient)}")
        print(f"The original remainder is : {originalRemainder} ,{bin(originalRemainder)}")
    
        quotient,remainder=sequenceDivision(num1, num2)

        # check if result is equal to result by simple division
        if (bin(originalQuotient)==bin(quotient)) and (bin(originalRemainder)==bin(remainder)):
            print("PASSED")
        else:
            print("FAILED")

if __name__ == "__main__":
    main()