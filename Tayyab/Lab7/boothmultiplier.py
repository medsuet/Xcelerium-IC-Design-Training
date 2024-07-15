"""
Name: boothmultipler.py
Date: 15-7-2024
Author: Muhammad Tayyab
Description: Booth's multipler algorithem for 32 bit integers
"""

def boothMultiplier(BR,QR):
    """
    Booth's multipler algorithem for 32 bit integers
    Arguments: BR: Multiplicand      QR: Multipler
    Returns: product of BR and QR
    """
    AC = 0
    Qn1 = 0                             # Qn+1 register
    n = 4                              # number of bits in integer

    for SC in range(n, 0, -1):          # SC from 32 to 0
        Qn = (QR & 1)                   # get last bit of QR
        
        print(f"AC:{bin(AC)}\nQ:{bin(QR)}\nBR:{bin(BR)}\nSC::{SC}\n")

        if ((Qn==0) and (Qn1==1)):      
            AC = AC + BR
        elif ((Qn==1) and (Qn1==0)):
            AC = AC + (~BR) + 1

        # Arthematic shift right 1 place
        # <AC bits><QR bits> as 1 group
        AC_lsb = AC & 1                 # store lsb of AC to place it at msb of QR
        AC_msb = AC & (1 << (n-1))      # store msb of AC for maintaining sign bit
        QR_lsb = QR & 1                 # store lsb of QR to save later in Qn+1 register

        AC = AC >> 1                    # shift AC right
        QR = QR >> 1                    # shift QR right

        if (AC_lsb == 1):               # place lsb of AC at msb of QR
            QR = QR | (1<<(n-1))
        else:
            QR = QR & (~(1<<(n-1)))
    
        if (Qn1 == 1):                  # place Qn+1 at msb of AC
            AC = AC | (1<<(n-1))
        #else:
        #    AC = AC & (~(1<<(n-1)))
        AC = AC | (AC_msb)
        
        Qn1 = QR_lsb
        
    return ( (AC << n) | QR )           # result is <AC bits><QR bits> (possibly a 64 bit number)

a=15
b=1
product = boothMultiplier(a,b)
print(bin(product), "  ", product)
print(bin(a*b), "  ", a*b)