import random
def nonRestore(dividend,divisor):
    A=0
    one=1<<31
    count=32
    while (count>0):
        MSB_check=A&one
        A=(A<<1)&0xffffffff|(dividend>>31)
        dividend = (dividend << 1)&0xffffffff #The 0xFFFFFFFF mask ensures that the value stays within the 32-bit range by masking the upper bits.
        if (MSB_check==0):
            comp_div=(~divisor)+1
            A=(A+comp_div)&0xffffffff
        else:
            A=(A+divisor)&0xffffffff
        MSB_check=A&one
        if (MSB_check==0):
            dividend=dividend|1
        else:
            dividend=dividend & ~(1)
        count=count-1
    MSB_check=A&one
    if (MSB_check!=0):
        A=(A+divisor)&0xffffffff
    #print("Qoutient is",dividend)
    #print("Remainder is",A)
    return dividend,A
for i in range(10):
    print("-----------Test",i,"-----------")
    num1 = random.randint(0,2**(32-1))
    num2 = random.randint(0,2**(32-1))
    q,r=nonRestore(num1,num2)
    if ((q==num1//num2)&(r==num1%num2)):
        print("Test Passed!!")
    else:
        print("Failure!!")