

def comp_2s(value, bits):
    mask = 2**31
    value1 = ~value + (0x01) + (1 << bits)

    # Negative values
    if (value < 0):
        value = value1 & (~(1<<bits))
    else:
        value = value1
    return value

def booths_multiplier(multiplier: int, multiplicand: int) -> int:
    ac = 0        # accumulator
    qn1  = 0      # Q n+1 bit (extended bit)
    sc = 32       # No. of bits multilplier bits (Q)
    tac = ac


    if (multiplier < 0):
        qr = comp_2s(multiplier,sc)
    else:
        qr = multiplier

    if (multiplicand < 0):
        m = comp_2s(multiplicand, sc)
    else:
        m = multiplicand

    for x in range(0,sc):
        qn = qr & 1    # last bit of multiplier

        print(ac,qr,qn)

        """ check Qn and Qn+1 """
        if ((qn == 0) and (qn1 == 1)):
            ac = ac + m

        elif ((qn == 1) and (qn1 == 0)):
            ac = ac + comp_2s(m, sc)

        else:
            ac = ac

        qr = qr >> 1

        """ check ac LSB ,if 1, insert 1 on Q MSB """
        if ( ac & 1 == 0):
            qr = qr
        else:
            qr = qr | 0x80000000

        """ check ac MSB, if 1, append 1 on ac MSB """
        if (ac & 0x80000000 == 0):
            ac = ac & 0xFFFFFFFF
            ac = ac >> 1
        else:
            ac = ac >> 1
            ac = ac | 0x80000000


        qn1 = qn

    ac = (ac << sc) | qr

    if(multiplier < 0):
        ac = -ac
    else:
        ac = ac

    if (multiplicand < 0):
        ac = -ac
    else:
        ac = ac

    return ac

print("\n==== 32-bit Signed Booth's Multiplier ====")
a = 2**31 - 1
b = -2**31
print("     Maximum Value = (2^31 - 1) =",a )
print("     Minimum Value = -2^31 =",b )
multiplier = int(input("\nEnter the value of Multiplier: "))
multiplicand = int(input("Enter the value of Multiplicand: "))

ans = booths_multiplier (multiplier, multiplicand)
value = multiplier*multiplicand

#print(b, bin(value), value)
print(f"\nThe Answer is {ans} and Python using {ans.bit_length()} bits.")

if(ans == value):
    print("Successfully multiplied")
else:
    print(f"Your Answer is not correct.")
    print(f"Booth's Answer = {ans}, Original Answer = {value}")



