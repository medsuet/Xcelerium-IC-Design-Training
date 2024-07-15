def Restoring_Division(Dividend,Divisor):
    num_bits=32
    N=num_bits
    A=0
    M=Divisor   #divisor
    Q=Dividend  #dividend
    A_Res=A #The value of A before subtraction with M

    array_AQ=[0]*num_bits*2
    array_A=[0]*num_bits
    array_Q=[0]*num_bits
    while (N!=0):
        array_A=DecimalToBinary(A,num_bits)
        array_Q=DecimalToBinary(Q,num_bits)

        array_AQ=TwoArraysConcatenator(array_A,array_Q)
        array_AQ=ArtithmeticLeftShift(array_AQ)
        (array_A,array_Q)=TwoArraysSplitter(array_AQ)
        A=BinaryToDecimal(array_A,32)

        A_Res=A;
        A=A-M;
        array_A=DecimalToBinary(A,32)
        if (array_A[0]==0):
            array_Q[31]=1
        elif (array_A[0]==1):
            array_Q[31]=0
            A=A_Res
        Q=BinaryToDecimal(array_Q,32)
        N=N-1
    Q=BinaryToDecimal(array_Q,32)

    print("Quotient= ",Q)
    print("Remainder= ",A)
    if(Q==-1):
        print("\nDIVISION BY ZERO\n")
    
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
def ArtithmeticLeftShift(array_AQ):
    for j in range(0,63,1):
        array_AQ[j]=array_AQ[j+1]
    array_AQ[63]=0
    array_AQ[0]=0
    return array_AQ
def TwoArraysSplitter(array_AQ):
    array_A=[0]*32
    array_Q=[0]*32
    for i in range(0,32,1):
        array_A[i]=array_AQ[i]
    for j in range(32,64,1):
        array_Q[j-32]=array_AQ[j]
    return (array_A,array_Q)
def TwoArraysConcatenator(array_AC,array_Q0):
    array_AC_Q0=[0]*64
    for i in range(0,32,1):
        array_AC_Q0[i]=array_AC[i]
    for j in range(32,64,1):
        array_AC_Q0[j]=array_Q0[j-32]
    return array_AC_Q0
Dividend=int(input("Enter the Dividend: "))
Divisor=int(input("Enter the Divisor: "))
Restoring_Division(Dividend,Divisor)