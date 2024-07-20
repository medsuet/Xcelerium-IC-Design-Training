#!/usr/bin/env python3


def Booth_Multiplier(multiplicand, multiplier):
    # Initialize variables
    BR = multiplicand
    QR = multiplier
    AC = 0
    SC = 32
    Q_1 = 0

    # Make sure QR and BR are in 32-bit signed integer format
    QR &= 0xFFFFFFFF
    BR &= 0xFFFFFFFF

    def sign_extend(val, bits=32):
        sign_bit = 1 << (bits - 1)
        return (val & (sign_bit - 1)) - (val & sign_bit)

    while SC != 0:
        if ((QR & 1 == 0 and Q_1 == 1)):
            AC = (AC + BR) & 0xFFFFFFFF
        elif ((QR & 1 == 1 and Q_1 == 0)):
            AC = (AC - BR) & 0xFFFFFFFF

        Q_1 = QR & 1
        QR = (QR >> 1) | ((AC & 1) << 31)
        AC = (AC >> 1) & 0x7FFFFFFF  # Shift AC right and maintain 32 bits
        if (AC & 0x40000000):        # Sign extend AC
            AC |= 0x80000000

        SC -= 1
#        print(f"AC: {sign_extend(AC)}, QR: {sign_extend(QR)}, BR: {sign_extend(BR)}, Q_1: {Q_1}")

    return sign_extend(QR)

# Example usage:
multiplicand = 7
multiplier = -3
result = Booth_Multiplier(multiplicand, multiplier)
print(f"Result: {result}")


