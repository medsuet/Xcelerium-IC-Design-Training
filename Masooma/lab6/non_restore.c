//***********Author: Masooma Zia***********
//***********Description: Non Restoring Division Algorithm***********
//***********Date: 17-07-2024***********
#include <stdio.h>
#include <stdint.h>
void nonRestore(uint32_t dividend,uint32_t divisor){
    uint32_t A=0;
    int one=1<<31;
    int count=32;
    int MSB_check;
    while (count>0){
        MSB_check=A&one;
        if (MSB_check==0){
            A=(A<<1)|(dividend>>31); //A after left shift of AQ as a single unit
            dividend <<=1; //dividend after left shift of AQ as a single unit
            //complement of divisor
            int comp_div=~divisor;
            comp_div += 1;
            A=A+comp_div;
        }
        else{
            A=(A<<1)|(dividend>>31);
            dividend <<=1;
            A=A+divisor;
        }
        MSB_check=A&one;
        if (MSB_check==0){
            dividend=dividend|1; //to set lsb of dividend equal to 1
        }
        else{
            dividend &= ~(1); //to set lsb of dividend equal to 0
        }
        count--;
    }
    MSB_check=A&one;
    if (MSB_check!=0){
        A=A+divisor;
    }
    printf("Quotient %d \n",dividend);
    printf("Remainder %d \n",A);

}
int main(){
    nonRestore(14,3);
    return 0;
}