//***********Author: Masooma Zia***********
//***********Description: Booth Multiplication Algorithm for 32-bit signed integers***********
//***********Date: 19-07-2024***********
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
int64_t boothMultiplier(int32_t multiplier,int32_t multiplicand){
    int32_t A=0;
    int32_t flipflop=0;
    int count=32;
    int shift;
    int32_t m;
    int32_t comp;
    while (count>0){
        int state=((1&multiplier)<<1)|flipflop; //to select state 
        if(state==2){
            comp=(~multiplicand)+1;
            A=A+comp;
        }
        else if(state==1){
            A=A+multiplicand;
        }
        m=multiplier>>1;
        int one=1;
        one=1<<31;
        m=(m)&(~one);
        flipflop=multiplier&1;
        if ((A&(1<<31))!=0){
            shift=A<<31;
            shift=shift|~(1<<31);
            A >>= 1;
        }
        else{
            shift=(A<<31);
            A >>= 1;
        }
        multiplier=m|(shift&one);
        count--;
        }
        int64_t result=0;
    result = ((int64_t)A << 32) | (uint32_t)multiplier;
    return result;
    }
//used to test booth multiplier by random number generation
void verifyBooth(){
    for (int i=0;i<10;i++){
        int signed num1=random()%100000;
        int signed num2=-random()%10000;
        long signed int ans=boothMultiplier(num1,num2);
        printf("\n");
        printf("Answer of %d and %d is %ld\n",num1,num2,ans);
        int tolerance=1;
            if (ans == num1*num2) {
                printf("Test Passed!!\n");
            }
        }
}
int main(){ 

    verifyBooth();

return 0;  
}