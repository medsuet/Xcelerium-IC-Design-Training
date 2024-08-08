#FILE:BOOTH MULTIPLIER
#AUTHOR:AHSAN JAVED

def complement(a):
    return (~a + 1) & 0xFFFFFFFF
#RS checks if sign bit is 1 then extend 
def arithmetic_right_shift(value, shift):
    if value & (1 << 63):
        return (value >> shift) | (~0 << (64 - shift))
    else:
        return value >> shift
#function performing operation
def booth_multiplier(multiplier, multiplicand):
    n = 32
    accumulator = 0
    Q_1 = 0
#maskng with 32 bit to make them 32 bit   
    multiplier &= 0xFFFFFFFF
    multiplicand &= 0xFFFFFFFF
    
    for _ in range(n):
        multiplier_lsb = multiplier & 1
        
        if multiplier_lsb == 0 and Q_1 == 1:
            accumulator = (accumulator + multiplicand) & 0xFFFFFFFF
        elif multiplier_lsb == 1 and Q_1 == 0:
            accumulator = (accumulator + complement(multiplicand)) & 0xFFFFFFFF
        
        Q_1 = multiplier_lsb
#combining them to make a 64 bit number       
        combined = (accumulator << 32) | multiplier
        combined = arithmetic_right_shift(combined, 1)
#separating acc and mult 
        accumulator = (combined >> 32) & 0xFFFFFFFF
        multiplier = combined & 0xFFFFFFFF
    
    result = (accumulator << 32) | multiplier
    if result & (1 << 63):
        result = -((~result + 1) & 0xFFFFFFFFFFFFFFFF)
    return result

def main():
    print(f"the product of -58000 and 0 is {booth_multiplier(-58000, 0)}")
    print(f"the product of -58000 and -58000 is {booth_multiplier(-58000, -58000)}")
    print(f"the product of -58000 and 12 is {booth_multiplier(-58000, 12)}")
    print(f"the product of 13 and 13 is {booth_multiplier(13, 13)}")
    print(f"the product of -169 and 169 is {booth_multiplier(-169, 169)}")
    print(f"the product of 780 and 0 is {booth_multiplier(780, 0)}")
    print(f"the product of 456 and 2 is {booth_multiplier(456, 2)}")
    print(f"the product of -1 and -1 is {booth_multiplier(-1, -1)}")
   

if __name__ == "__main__":
    main()