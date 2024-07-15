def shiftLeft(A, Q):
    temp = (A << 32) | (Q & 0xffffffff)
    temp = temp << 1
    A = (temp >> 32) & 0xffffffff
    Q = temp & 0xffffffff
    return (A, Q)

Q = int(input("Enter dividend : "))
M = int(input("Enter divisor : "))
N = 32
A = 0

for i in range(0, N, 1):
    (A, Q) = shiftLeft(A, Q)
    
    if A & 0x80000000 == 0:  
        A = (A - M) & 0xffffffff
    else:
        A = (A + M) & 0xffffffff
    
    if A & 0x80000000 == 0:  
        Q = Q | 1
    else:
        Q = Q & 0xfffffffe

if A & 0x80000000 != 0:  
    A = (A + M) 
    A = A & 0xffffffff  #making value of A in 32 bits

print("Quotient :", Q)
print("Remainder :", A)