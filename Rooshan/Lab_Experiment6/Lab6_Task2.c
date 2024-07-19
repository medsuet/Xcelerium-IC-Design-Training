#include <stdio.h>
#include <math.h>
unsigned int BitChecking_31=(1<<31);
unsigned int one=1;
int Set_or_clear(int Number,int bit_number,int set_or_clear);
int main(){
    //Clear a bit
    int Number1=10;
    int bit_number=1;
    int set_or_clear=0;
    printf("Number before clearing bit number %d: %d\n",bit_number,Number1);
    Number1=Set_or_clear(Number1,bit_number,set_or_clear);
    printf("Number after clearing bit number %d: %d\n",bit_number,Number1);
    //Set a bit
    int Number2=10;
    bit_number=2;
    set_or_clear=1;
    printf("Number before setting bit number %d: %d\n",bit_number,Number2);
    Number2=Set_or_clear(Number2,bit_number,set_or_clear);
    printf("Number after setting bit number %d: %d\n",bit_number,Number2);
    return 1;
}
int Set_or_clear(int Number,int bit_number,int set_or_clear){
    int Num=Number;
    int N=32;
    int BIT=1;
    BIT=BIT<<bit_number;
    int frame=0xffffffff;
    if (set_or_clear==0){
        Num=Num&(BIT^frame);
    }
    else{
        Num=Num|BIT;
    }
    return Num;
}
