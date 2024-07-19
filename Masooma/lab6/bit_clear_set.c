//***********Author: Masooma Zia***********
//***********Description: Clearing and setting a bit in 32-bit integer***********
//***********Date: 17-07-2024***********
#include <stdio.h>
#include <math.h>
int clearOrSetBit(char choice,int bit_num, int num){
    int one_on_lower_bits=0;
    int result;
    //clear
    int ans=~(1);
    int shift_by_bits = ans<<(bit_num-1);
    for (int i=bit_num-2;i>=0;i--){
        int one=pow(2,i);
        one_on_lower_bits += one;
    }
    shift_by_bits=shift_by_bits|one_on_lower_bits; //set all bits except desired bit
    if (choice=='c'){ //to clear
        result=num&shift_by_bits;
    }
    else if (choice=='s'){ //to set
        result=num|(~shift_by_bits);
    }
    return result;
}
int main(){
    
    printf("%d\n",clearOrSetBit('c',1,17));
    printf("%d\n",clearOrSetBit('s',2,17));
    

    return 0;
}
    
