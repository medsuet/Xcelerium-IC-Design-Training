import math

booth = [0] * 64
M = [0] * 32
M_neg = [0] * 32
q = 0

def multiplicand(a):
    global M
    if a >= 0:
        i = 31
        while a > 0:
            rem = a % 2
            a = a // 2
            M[i] = rem
            i -= 1
    else:
        a = a + (1 << 32)
        i = 31
        while a > 0:
            rem = a % 2
            a = a // 2
            M[i] = rem
            i -= 1
        M[0] = 1

def multiplier(a):
    global booth
    if a >= 0:
        i = 63
        while a > 0:
            rem = a % 2
            a = a // 2
            booth[i] = rem
            i -= 1
    else:
        a = a + (1 << 32)
        i = 63
        while a > 0:
            rem = a % 2
            a = a // 2
            booth[i] = rem
            i -= 1
        booth[32] = 1

def add(m):
    global booth
    carry = 0
    for i in range(31, -1, -1):
        sum = m[i] + booth[i] + carry
        if sum == 2:
            sum = 0
            carry = 1
        elif sum == 3:
            sum = 1
            carry = 1
        else:
            carry = 0
        booth[i] = sum

def neg():
    global M_neg
    carry = 0
    for i in range(32):
        M_neg[i] = 1 if M[i] == 0 else 0

    sum = 1 + M_neg[31]
    if sum == 2:
        carry = 1
        sum = 0
    M_neg[31] = sum
    for i in range(30, -1, -1):
        sum = M_neg[i] + carry
        if sum == 2:
            carry = 1
            sum = 0
        else:
            carry = 0
        M_neg[i] = sum

def arithmetic_right_shift():
    global q, booth
    q = booth[63]
    for i in range(63, 0, -1):
        booth[i] = booth[i - 1]

def dec():
    result = 0
    for i in range(63, -1, -1):
        if booth[i] == 1:
            result += int(math.pow(2, 63 - i))
    if booth[0] == 1:
        return result - int(math.pow(2, 64))
    return result

def main():
    global q
    a = int(input("Enter the Multiplicand (less than 2147483648 and greater than -2147483649): "))
    b = int(input("Enter the Multiplier: "))

    multiplicand(a)
    multiplier(b)
    neg()

    n = 32
    while n > 0:
        if booth[63] == 0 and q == 1:
            add(M)  # AC = AC + M
        elif booth[63] == 1 and q == 0:
            add(M_neg)  # AC = AC - M
        arithmeticShiftRight()
        n -= 1

    print("The output in binary is: ", end="")
    for i in range(64):
        print(booth[i], end="")
    print("\nThe output in decimal is: ", dec())

main()
