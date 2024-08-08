#file description : this code perform non restoring division algorithm

import random
#following function perform shift left operation 
def shiftLeft(A, Q):
    temp = (A << 32) | (Q & 0xffffffff)  #combining accumulator and dividend
    temp = temp << 1                     #perform left shift operation
    #getting value of accumulator and dividend after performing left shift
    A = (temp >> 32) & 0xffffffff    
    Q = temp & 0xffffffff
    return (A, Q)

def division(Q,M):
    #if divisible by zero return None 
    if (M == 0):
        return None
    N = 32  #32 bit number
    A = 0
    for i in range(0, N, 1):
        (A, Q) = shiftLeft(A, Q) #perform left shift on A and Q as single unit

        if A & 0x80000000 == 0:   #checking msb of accumulator 
            A = (A - M) & 0xffffffff   #A=A-M
        else:
            A = (A + M) & 0xffffffff   #A=A+M

        if A & 0x80000000 == 0:   #checking msb of accumulator 
            Q = Q | 0x00000001    #making lsb of dividend 1
        else:
            Q = Q & 0xfffffffe    #making lsb of dividend 0

    if A & 0x80000000 != 0:     #last check on msb of accumulator
        A = (A + M)             #A=A+M
        A = A & 0xffffffff  

    return (Q,A)


#random testing
for i in range(100):
    Q = random.randint(1, 10000)
    M = random.randint(1, 10000)
    reg1 = Q
    reg2 = M 
    result = division(Q, M)
    if result is None:
        print("Division by zero is not allowed.")
    else:
        quotient, remainder = result
        if quotient == reg1 // reg2 and remainder == reg1 % reg2:
            print("correct")
        else:
            print("incorrect")