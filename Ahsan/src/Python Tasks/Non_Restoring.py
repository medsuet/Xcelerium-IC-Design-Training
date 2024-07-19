#FILE:NON RESTORING DIVISION
#AUTHOR:AHSAN JAVED

#functon for takng 2's compliment
def complment(a):
    return (~a + 1) & 0xFFFFFFFF

#functon for dividing
def Non_Restoring(divider,dividend):
    if (divider == 0):
        print("invalid")
    else:

        n         = 32             
        A         = 0x00000000             
        divider  &= 0xFFFFFFFF     
        dividend &= 0xFFFFFFFF

        for i in range(n):
#findinf the msb of A
            reminder_msb = A & 0x80000000
#combining reminder and dividend
            combined = ((A<<32) | dividend) & 0xFFFFFFFFFFFFFFFF
#shifing to eft lby 1 bit
            combined = combined << 1
#updated A and Q
            A        = (combined >> 32) & 0xFFFFFFFF
            dividend = combined & 0xFFFFFFFF
            if (reminder_msb == 0x80000000):
                A    = (A + divider) & 0xFFFFFFFF
            else:
                A    = (A - divider) & 0xFFFFFFFF

            reminder_msb = A & 0x80000000

            if (reminder_msb == 0x80000000):
                dividend  = dividend & 0xFFFFFFFE
            else:
                dividend  = dividend | 0x00000001

    #now outside the for loop last step
        if (reminder_msb == 0x80000000):
            A = (A + divider) & 0xFFFFFFFF
            print(A,dividend)
        else:
            print(A,dividend)

def main():
    Non_Restoring(20000,500001)
    Non_Restoring(0,500001)


if __name__ == "__main__":
    main()


