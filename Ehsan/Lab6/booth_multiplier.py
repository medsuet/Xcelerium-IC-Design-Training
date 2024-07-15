def ArithmeticShiftRight(A, Q):
    temp = (A << 32) | (Q & 0xffffffff)
    temp = temp >> 1
    if (A & 0x80000000) != 0:
        temp |= (1 << 63)
    A = (temp >> 32) & 0xffffffff
    Q = temp & 0xffffffff
    return (A, Q)

def boothMultiplier(multiplicand, multiplier):
    Q = multiplier
    N = 32
    A = 0
    Q_1 = 0
    for i in range(0,N):
        print(bin(A)[2:],"   ",bin(Q)[2:])
        multiplierLSB = Q & 0x00000001
        if (multiplierLSB == 1 and Q_1 == 0):
            A = (A - multiplicand) & 0xffffffff
        elif (multiplierLSB == 0 and Q_1 == 1):
            A = (A + multiplicand) & 0xffffffff
        (A, Q) = ArithmeticShiftRight(A, Q)
        Q_1 = multiplierLSB
    product = (A << 32) | (Q & 0xffffffff)
    return product

multiplicand = 2
multiplier = -2

product = int(boothMultiplier(multiplicand, multiplier))
print(bin(product)[2:])
print(f"{multiplicand} X {multiplier} = {product}")


