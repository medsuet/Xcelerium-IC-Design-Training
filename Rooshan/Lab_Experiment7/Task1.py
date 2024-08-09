def Booth_Multiplier(Multiplicand,Multiplier):
    num_bits=32
    n=num_bits
    count=n
    AC=0
    M=Multiplicand
    Q0=Multiplier
    Q_n1=0
    array_AC_Q0_Q_n1=([0]*num_bits*4)
    array_AC_Q0=([0]*num_bits*2)
    array_AC=([0]*num_bits)
    array_Q_n1=([0]*num_bits)
    array_M=([0]*num_bits)
    array_Q0=([0]*num_bits*4)
    array_M=DecimalToBinary(M,32)
    
    array_AC=DecimalToBinary(AC,32)
    array_Q0=DecimalToBinary(Q0,32)
    array_Q_n1=DecimalToBinary(Q_n1,32)

    while(count!=0):
        if (array_Q0[31]==0 and array_Q_n1[31]==1):
            AC=AC-M
        elif (array_Q0[31]==1 and array_Q_n1[31]==0):
            AC=AC+M
#        print("AC=",AC," ","array_AC=",array_AC)
#        print("Q0=",Q0," ","array_Q0=",array_Q0)
#        print("Q_n1=",Q_n1," ","array_Q_n1=",array_Q_n1)
        array_AC=DecimalToBinary(AC,32)
        array_AC_Q0_Q_n1=ThreeArraysConcatenator(array_AC,array_Q0,array_Q_n1)
        array_AC_Q0_Q_n1=ArtithmeticRightShift(array_AC_Q0_Q_n1)
        (array_AC,array_Q0,array_Q_n1)=ThreeArraysSplitter(array_AC_Q0_Q_n1)
        count=count-1
        AC=BinaryToDecimal(array_AC,32)
    array_AC_Q0=TwoArraysConcatenator(array_AC,array_Q0)
#    print("AC=",AC," ","array_AC=",array_AC)
    Q0=BinaryToDecimal(array_Q0,32)
#    print("array_AC_Q0=",array_AC_Q0)
    Result=BinaryToDecimal(array_AC_Q0,64)
    print("\n")
    print("\nResult= ",Result)

def DecimalToBinary(Num,Numbits):
    array_Num=[0]*Numbits
    num=int(Num)
    remainder=0
    i=0
    if (num>0):
        while (num>=1):
            remainder=num%2
            array_Num[Numbits-1-i]=remainder
            i+=1
            num=num//2
    elif (num<0):
        array_Num[0]=1
        num=2**(Numbits-1)+num
        while (num>=1):
            remainder=num%2
            array_Num[Numbits-1-i]=remainder
            i+=1
            num=num//2
    return array_Num

def ThreeArraysConcatenator(array_AC,array_Q0,array_Q_n1):
    array_AC_Q0_Q_n1=[0]*96
    for i in range(0,32,1):
        array_AC_Q0_Q_n1[i]=array_AC[i]
    for j in range(32,64,1):
        array_AC_Q0_Q_n1[j]=array_Q0[j-32]
    for k in range(64,96,1):
        array_AC_Q0_Q_n1[k]=array_Q_n1[k-64]
    return (array_AC_Q0_Q_n1)

def ArtithmeticRightShift(array_AC_Q0_Q_n1):
    array_AC_Q0_Q_n1_new=array_AC_Q0_Q_n1
    c=array_AC_Q0_Q_n1[0]
    for j in range(0,95,1):
        array_AC_Q0_Q_n1_new[95-j]=array_AC_Q0_Q_n1_new[95-(j+1)]
    array_AC_Q0_Q_n1_new[0]=c
    return array_AC_Q0_Q_n1_new
    
def ThreeArraysSplitter(array_AC_Q0_Q_n1):
    array_AC=[0]*32
    array_Q0=[0]*32
    array_Q_n1=[0]*32
    for i in range(0,32,1):
        array_AC[i]=array_AC_Q0_Q_n1[i]
    for j in range(32,64,1):
        array_Q0[j-32]=array_AC_Q0_Q_n1[j]
    for k in range(64,96,1):
        array_Q_n1[k-64]=array_AC_Q0_Q_n1[k]
    return (array_AC,array_Q0,array_Q_n1)

def BinaryToDecimal(array_Num,Numbits):
    Result = 0
    if (array_Num[0] == 1):
        Result -= 2**(Numbits - 1)

    for i in range(1,Numbits,1):
        if (array_Num[i] == 1):
            Result += 2**(Numbits-i-1)
        else:
            Result=Result
    return Result

def TwoArraysConcatenator(array_AC,array_Q0):
    array_AC_Q0=[0]*64
    for i in range(0,32,1):
        array_AC_Q0[i]=array_AC[i]
    for j in range(32,64,1):
        array_AC_Q0[j]=array_Q0[j-32]
    return array_AC_Q0
Multiplicand=int(input("Enter the Multiplicand you want to multiply: "))
Multiplier=int(input("Enter the Multiplier you want to multiply: "))
Booth_Multiplier(Multiplicand,Multiplier)