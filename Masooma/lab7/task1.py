import random
def boothMultiplier(multiplier,multiplicand):
    A=0
    flipflop=0
    count=32
    while (count>0):
        state=(((1&multiplier)<<1))|flipflop
            
        if (state==2):
            comp=(~multiplicand)+1
            A=A+comp
            #print("2")
            #print("A is",A)
            #print("Multiplier is",multiplier)
        elif (state==1):
            A=A+multiplicand
            #print("1")
            #print("A is",A)
            #print("Multiplier is",multiplier)
        m=multiplier>>1
        one=1
        one=1<<31
        m=m&(~one)
        flipflop=multiplier&1
        if(A&((1<<31))!=0):
            shift=(A<<31)
            shift=shift|(~(1<<31))
            A = A>>1
        else:
            shift=A<<31
            A = A>>1
        multiplier=m|(shift&one)
        if A >= 2**31:
            A = A - 2**32
        else:
            A = A
        if multiplier >= 2**31:
            multiplier = multiplier - 2**32
        else:
            multiplier = multiplier

        #print("A is",A)
        #print("multiplier is",multiplier)
        count=count-1
    zero=0
    result=(A<<32)|(multiplier&0xffffffff)
    if result >= 2**63:
        result = result - 2**64
    else:
        result = result
    return result

for i in range(10):
    print("-----------Test",i,"-----------")
    num1 = random.randint(-2**31,(2**31)-1)
    num2 = random.randint(-2**31,(2**31)-1)
    ans=boothMultiplier(num1,num2)
    print("num1=",num1)
    print("num2=",num2)
    if (ans==num1*num2):
        print("Test Passed!!")
    else:
        print(ans)
        print("Failure!!")

            