#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>
#define num_bits 32
void DecimalToBinary(int*array_Num,int64_t Num,int Numbits);
void ThreeArraysConcatenator(int* array_AC_Q0_Q_n1,int* array_AC,int* array_Q0,int* array_Q_n1);
void ArtithmeticRightShift(int* array_AC_Q0_Q_n1);
void ThreeArraysSplitter(int* array_AC_Q0_Q_n1,int* array_AC,int* array_Q0,int* array_Q_n1);
int64_t BinaryToDecimal(int*array_Num,int Numbits);
void TwoArraysConcatenator(int* array_AC_Q0,int* array_AC,int* array_Q0);

int main(){
    int n=num_bits;
    int64_t Result;
    int count=n;
    int64_t AC=0;
    int64_t M=15;
    int64_t Q0=-15;
    int64_t Q_n1=0;
    int* array_AC_Q0_Q_n1=(int*)calloc(num_bits*4,sizeof(int));
    int* array_AC_Q0=(int*)calloc(num_bits*2,sizeof(int));
    int* array_AC=(int*)calloc(num_bits,sizeof(int));
    int* array_Q_n1=(int*)calloc(num_bits,sizeof(int));
    int* array_M=(int*)calloc(num_bits,sizeof(int));
    int* array_Q0=(int*)calloc(num_bits,sizeof(int));
    DecimalToBinary(array_M,M,32);
    
    DecimalToBinary(array_AC,AC,32);
    DecimalToBinary(array_Q0,Q0,32);
    DecimalToBinary(array_Q_n1,Q_n1,32);

    while(count!=0){
        if (*(array_Q0+31)==0 && *(array_Q_n1+31)==1){
            AC=AC-M;
        }
        else if (*(array_Q0+31)==1 && *(array_Q_n1+31)==0){
            AC=AC+M;
        }

        DecimalToBinary(array_AC,AC,32);
        ThreeArraysConcatenator(array_AC_Q0_Q_n1,array_AC,array_Q0,array_Q_n1);
        ArtithmeticRightShift(array_AC_Q0_Q_n1);
        ThreeArraysSplitter(array_AC_Q0_Q_n1,array_AC,array_Q0,array_Q_n1);
        count=count-1;
        AC=BinaryToDecimal(array_AC,32);
    }
    TwoArraysConcatenator(array_AC_Q0,array_AC,array_Q0);
    Result=BinaryToDecimal(array_AC_Q0,64);
    printf("\n");
    printf("\nResult= %ld \n",Result);
    free(array_AC_Q0_Q_n1);
    free(array_AC_Q0);
    free(array_AC);
    free(array_Q_n1);
    free(array_M);
    free(array_Q0);
}
void DecimalToBinary(int*array_Num,int64_t Num,int Numbits){
    int64_t num=Num;
    int i=0;
    int64_t remainder;
    for (int j = 0; j < Numbits; j++)
    {
        *(array_Num+j)=0;
    }    
    if (num>0){
        *(array_Num+(0))=0;
        while (num>=1){
            remainder=num%2;
            
            *(array_Num+(Numbits-1-i))=remainder;
            i++;
            num=num/2;
        }
    }
    else if (num<0){
        *(array_Num+(0))=1;
        num=(int64_t)pow(2, (Numbits-1))+num;
        while (num>=1){
            remainder=num%2;
            *(array_Num+(Numbits-1-i))=remainder;
            i++;
            num=num/2;
        }
    }  
}

void ThreeArraysConcatenator(int* array_AC_Q0_Q_n1,int* array_AC,int* array_Q0,int* array_Q_n1){
    for(int i=0;i<32;++i){
        *(array_AC_Q0_Q_n1+i)=*(array_AC+i);
    }
    for(int j=32;j<64;++j){
        *(array_AC_Q0_Q_n1+j)=*(array_Q0+j-32);
    }
    for(int k=64;k<96;++k){
        *(array_AC_Q0_Q_n1+k)=*(array_Q_n1+k-64);
    }
}
void ArtithmeticRightShift(int* array_AC_Q0_Q_n1){
    int c=*(array_AC_Q0_Q_n1);
    for(int j=0;j<95;++j){
        *(array_AC_Q0_Q_n1+95-j)=*(array_AC_Q0_Q_n1+95-(j+1));
    }
    *(array_AC_Q0_Q_n1)=c;
}
void ThreeArraysSplitter(int* array_AC_Q0_Q_n1,int* array_AC,int* array_Q0,int* array_Q_n1){
    for(int i=0;i<32;++i){
        *(array_AC+i)=*(array_AC_Q0_Q_n1+i);
    }
    for(int j=32;j<64;++j){
        *(array_Q0+j-32)=*(array_AC_Q0_Q_n1+j);
    }
    for(int k=64;k<96;++k){
        *(array_Q_n1+k-64)=*(array_AC_Q0_Q_n1+k);
    }
}

int64_t BinaryToDecimal(int* array_Num, int Numbits) {
    int64_t Result = 0;

    if (array_Num[0] == 1) {
        Result -= (int64_t)pow(2, Numbits - 1);
    }

    for (int i = 1; i < Numbits; i++) {
        if (array_Num[i] == 1) {
            Result += (int64_t)pow(2, Numbits-i-1);
        }
        else{
            Result=Result;
        }
    }

    return Result;
}

void TwoArraysConcatenator(int* array_AC_Q0,int* array_AC,int* array_Q0){
    for(int i=0;i<32;++i){
        *(array_AC_Q0+i)=*(array_AC+i);
    }
    for(int j=32;j<64;++j){
        *(array_AC_Q0+j)=*(array_Q0+j-32);
    }
}