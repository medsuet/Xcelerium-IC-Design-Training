def ArithmeticShiftRight(A, Q):
    temp = (A << 32) | (Q & 0xffffffff)
    if temp & 0x8000000000000000:  
        temp = (temp >> 1) | (0x8000000000000000)
    else:
        temp = temp >> 1
    A = (temp >> 32) & 0xffffffff
    Q = temp & 0xffffffff
    return A, Q

def boothMultiplier(multiplicand, multiplier):
    Q = multiplier
    N = 32
    A = 0
    Q_1 = 0
    for i in range(N):
        multiplierLSB = Q & 0x00000001
        if multiplierLSB == 1 and Q_1 == 0:
            A = (A - multiplicand) & 0xffffffff
        elif multiplierLSB == 0 and Q_1 == 1:
            A = (A + multiplicand) & 0xffffffff
        A, Q = ArithmeticShiftRight(A, Q)
        Q_1 = multiplierLSB

    product = (A << 32) | (Q & 0xffffffff)
    if (product & 0x8000000000000000): 
        product -= 0x10000000000000000

    return product

multiplicand = 2
multiplier = -2

product = boothMultiplier(multiplicand, multiplier)
print(f"{multiplicand} x {multiplier} = {product}")
