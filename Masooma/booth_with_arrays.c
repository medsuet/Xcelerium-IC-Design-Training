// Description: Booth Multiplier
// Author: Masooma Zia
// Date: 08-07-2024
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
int flipflop=0;
signed int accumulator=0;
void swap(int *a, int *b) {
    int temp;
    temp=*a;
    *a=*b;
    *b=temp;
}
//Used to print the array
void printArray(int *arr,int size){
    int *ptr_arr=arr;
    if (ptr_arr==NULL){
        printf("No allocation\n");
    }
    for (int i=0;i<size;i++){
        printf("%d",*(ptr_arr+i));
    }
    printf("\n");
}
//Used to reverse the array
void reverseArray(int *arr, int size) {
    int *ptr_arr=arr;
   for (int i=0;i<size/2;i++){
        swap(ptr_arr+i,ptr_arr+(size-i-1));
    }
}
//Used to convert integer to binary using array
int* inttobin(signed long int n,int size){
    int i;
    int carry=1;
    int temp;
    int *a=(int *)calloc(size,sizeof(int));
    if (n<0){
        temp=1;
        n=-n;
    }
    for(i=0;n>0;i++){
        a[i]=n%2;    
        n=n/2;    
    }
    reverseArray(a,size);
    if (temp==1){
        for (int j=0;j<size;j++){
            if (a[j]==1){
                a[j]=0;
            }
            else{
                a[j]=1;
            }
        }
        //printf("\n");
        for (int i=size-1;i>=0;i--){
            if (a[i]==1&&carry==1){
                a[i]=0;
            }
            else if (a[i]==0&&carry==1){
                a[i]=1;
                carry=0;
            }
            else{
                a[i]=a[i];
            }
        }
    }
     
      
    for(int i=0;i<size;i++)    
    {    
    //printf("%d",a[i]);    
    }    
    //printf("\n");
    return a;
}
//used to sum the two integers using array of binary numbers

int* sum(int *result,signed int num){
    int *num_result=inttobin(num,32);
    int carry=0;
    int num1,num2,res;
    for (int i=31;i>=0;i--){
        num1=num_result[i];
        num2=result[i];
        res=num1+num2;
        //printf("\n%d\n",res);
        if(res==2&&carry==0){
            result[i]=0;
            carry=1;
        }
        else if (res==2&&carry==1){
            result[i]=1;
            carry=1;
        }
        else if (res==1&&carry==1){
            result[i]=0;
            carry=1;
        }
        else if (res==1&&carry==0){
            result[i]=1;
            carry=0;
        }
        else if (res==0&&carry==0){
            result[i]=0;
            carry=0;
        }
        else if (res==0&&carry==1){
            result[i]=1;
            carry=0;
        }
    }
    //printf("Binary of sum:\n");
    //printArray(result,64);
    return result;
    

}
//Used to concatenate the two arrays of binary numbers
int* concatenate(int *arr1,int *arr2,int size1,int size2){
    int size=size1+size2;
    signed int *arr=(signed int *)malloc(size*sizeof(int));
    int count=0;
    for (int i=0;i<size1;i++){
        arr[i]=arr1[i];
    }
    for (int i=size1;i<size;i++){
        arr[i]=arr2[count];
        count++;
    }
    return arr;
}
//Used to convert binary array into integer
signed long binaryToInt(int *num_arr, int size) {
    signed long num_result = 0;
    int j;
    int carry=1;
    int temp=num_arr[0];
    if (temp==1){
        for (int j=0;j<size;j++){
            if (num_arr[j]==1){
                num_arr[j]=0;
            }
            else{
                num_arr[j]=1;
            }
        }
        for (int i=size-1;i>=0;i--){
            if (num_arr[i]==1&&carry==1){
                num_arr[i]=0;
            }
            else if (num_arr[i]==0&&carry==1){
                num_arr[i]=1;
                carry=0;
            }
            else{
            num_arr[i]=num_arr[i];
            }
        }
        //printf("\nArray of binarytoint comp:\n");
        //printArray(num_arr,size);
    }
    
    // Convert the binary array to an integer
    for (int i = 0; i < size; i++) {
        if (num_arr[i] == 1) {
            num_result += (1LL << (size - 1 - i)); // (1LL << n) is the same as pow(2, n)
        }
    }

    // Check if the number is negative (MSB is 1) and adjust for two's complement
    if (temp == 1) {
        num_result = -num_result;
    }

    return num_result;
}
//Used to right shift by 1
int* rightShift(int *result,signed int num_q){
    int temp=result[63];
    signed long int result_int=binaryToInt(result,64);
    //printf("Value of concatenation result: %ld\n",result_int);
    signed long int shift=result_int>>1;
    //printf("Value of shifting result: %ld\n",shift);
    flipflop=temp;
    //printf("FlipFlop: %d\n",flipflop);
    //printf("Binary of shift\n");
    result=inttobin(shift,64);
    return result;
}
//used to take two complement of a signed integer
signed long int twosComplement(signed int num) {
    int carry=1;
    //printf("Binary of num_m: ");
    int *num_arr=inttobin(num,32);
    for (int i=0;i<32;i++){
        if (num_arr[i]==1){
            num_arr[i]=0;
        }
        else{
            num_arr[i]=1;
        }
        //printf("%d",num_arr[i]);
    }
    //printf("\n");
    for (int i=31;i>=0;i--){
        if (num_arr[i]==1&&carry==1){
            num_arr[i]=0;
        }
        else if (num_arr[i]==0&&carry==1){
            num_arr[i]=1;
            carry=0;
        }
        else{
            num_arr[i]=num_arr[i];
        }
    }
    signed int result=binaryToInt(num_arr,32);
    //printf("Binary of complement:\n");
    inttobin(result,32);
    return result;
}
//used to execute the flowchart of booth multiplier
signed long int boothMultiplier(signed int num_q,signed int num_m){
    int *num_arr;
    int state;
    int count=32;
    signed long int m_result;
    //printf("Binary of num_q\n");
    num_arr=inttobin(num_q,32);
    //printf("Binary of accumulator\n");
    int *acc_arr=inttobin(accumulator,32);
    int *result=concatenate(acc_arr,num_arr,32,32);
    //printf("Binary of concatenation:\n");
    //printArray(result,64);
    while (count!=0){
        if (result[63]==0&&flipflop==0){
            //printf("\n");
            result=rightShift(result,num_q);
        }
        else if (result[63]==0&&flipflop==1){
            printf("\n");
            result=sum(result,num_m);
            result=rightShift(result,num_q);
        }
        else if (result[63]==1&&flipflop==0){
            //printf("\n");
            signed long int num_m_comp=twosComplement(num_m);
            result=sum(result,num_m_comp);
            result=rightShift(result,num_q);
        }
        else if(result[63]==1&&flipflop==1){
            //printf("\n");
            result=rightShift(result,num_q);
        }
        count--;
    }
    flipflop=0;
    accumulator=0;
    signed long int final=binaryToInt(result,64);
    return final;
}
//used to test booth multiplier by random number generation
void verifyBooth(){
    for (int i=0;i<10;i++){
        int signed num1=random()%100000;
        int signed num2=random()%10000;
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