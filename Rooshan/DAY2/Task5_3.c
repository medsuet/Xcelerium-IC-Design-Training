#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int counter1=0;
int counter2=0;
int* Allocate_Memory(int size,int*Array_of_Addresses);
void Free_Memory(int* Array,int*Array_of_Addresses);
void Memory_Leak_Detector(int * Array_of_Addresses);
#define AddressArrayLength 10
int main() 
{
    int *Array_of_Addresses=(int*)calloc(AddressArrayLength,sizeof(int));
    int *Array_of_integers1;
    int *Array_of_integers2;
    int n;
    printf("Enter size of the array\n");
    scanf("%d",&n);
    Array_of_integers1=Allocate_Memory(n,Array_of_Addresses);
    for (int i = 0; i < n; i++)
    {
        Array_of_integers1[i]=i;
    }
    int n2;
    printf("Enter size of the array\n");
    scanf("%d",&n2);
    Array_of_integers2=Allocate_Memory(n,Array_of_Addresses);
    Free_Memory(Array_of_integers1,Array_of_Addresses);
//    Free_Memory(Array_of_integers2,Array_of_Addresses);
    for (int i = 0; i < n2; i++)
    {
        Array_of_integers1[i]=n-i;
    }
    Memory_Leak_Detector(Array_of_Addresses);
    free(Array_of_Addresses);
    return 1;
}
void Memory_Leak_Detector(int * Array_of_Addresses){
    int x=0;
    for (int i = 0; i < AddressArrayLength; i++)
    {
        if (Array_of_Addresses[i]!=0){
            printf("Memory Leaked");
            x=1;
        }
    }
    if (x==0){
        printf("\nNo Memory Leaked");
    }
}

int* Allocate_Memory(int size,int* Array_of_Addresses){
    int *Array;
    Array=(int *)(calloc(size,sizeof(int)));
    Array_of_Addresses[counter1]=Array;
    counter1=counter1+1;
    return Array;
    
}
void Free_Memory(int* Array,int*Array_of_Addresses){
    free(Array);
    int* Address;
    for (int i = 0; i < counter1; i++)
    {
        if (Array_of_Addresses[i]==Array){
            Array_of_Addresses[i]=0;
        }
    }
}