#file description : this code perform multiplication by booth algorithm


import random

# Function to perform arithmetic right shift operation on Accumulator and Multiplier
def ArithmeticShiftRight(A, Q):
    temp = (A << 32) | (Q & 0xffffffff)
    if temp & 0x8000000000000000:  # checking msb
        temp = (temp >> 1) | (0x8000000000000000)
    else:
        temp = temp >> 1
    # getting value of A and Q from temp after arithmetic right shift operation
    A = (temp >> 32) & 0xffffffff
    Q = temp & 0xffffffff
    return A, Q

# Function to perform multiplication using Booth's algorithm
def boothMultiplier(multiplicand, multiplier):
    Q = multiplier
    N = 32
    A = 0
    Q_1 = 0
    for i in range(N):
        multiplierLSB = Q & 0x00000001  
        if multiplierLSB == 1 and Q_1 == 0:   # checking multiplier lsb and previous multiplier lsb
            A = (A - multiplicand) & 0xffffffff  # A = A - M
        elif multiplierLSB == 0 and Q_1 == 1: # checking multiplier lsb and previous multiplier lsb
            A = (A + multiplicand) & 0xffffffff   # A = A + M
        A, Q = ArithmeticShiftRight(A, Q)  # perform arithmetic right shift on A and Q as single unit
        Q_1 = multiplierLSB  
    # combining accumulator and Q to make product
    product = (A << 32) | (Q & 0xffffffff)
    # Convert to signed integer if necessary
    if product & 0x8000000000000000:
        product -= 0x10000000000000000

    return product


#random testing
for i in range(1000):
    multiplicand = random.randint(-100000,1000000)
    multiplier = random.randint(-100000,1000000)
    product = boothMultiplier(multiplicand, multiplier)

    if product == multiplicand * multiplier:
        print("correct")
    else:
        print("incorrect")
        print(multiplier, multiplicand,product,"       ",multiplier*multiplicand)
