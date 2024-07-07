 #include <stdio.h>
#include <stdlib.h>
int* createDynamicArray(int size);
void extendArray(int *arr,int size,int newSize);
int main() 
{
    int *Array_of_integers;
    int n,i,value,SUM,NewSize,Answer_1_or0;
    SUM=0;
    printf("Enter size of the array\n");
    scanf("%d",&n);
    printf("Entered number of  elements = %d\n",n);
    Array_of_integers=createDynamicArray(n);
    for (i=0;i<n;++i){
        printf("Enter integer value for index %d ",i);
        scanf("%d",&value);
        Array_of_integers[i]=value;
    }
    for (i=0;i<n;++i){
        SUM+=Array_of_integers[i];
    }
    printf("\nSum of the elements = %d",SUM);
    printf("\nAverage of the elements = %f",(float)SUM/(float)n);
    printf("\nDo you want to extend this array(1/0)?");
    scanf("%d",&Answer_1_or0);
    if (Answer_1_or0==1){
        printf("Enter new size: ");
        scanf("%d",&NewSize);
        extendArray(Array_of_integers,n,NewSize);
        for (i=n;i<NewSize;++i){
            printf("Enter integer value for index %d ",i);
            scanf("%d",&value);
            Array_of_integers[i]=value;
        }
        for (i=n;i<NewSize;++i){
            SUM+=Array_of_integers[i];
        }
        printf("\nSum of the elements = %d",SUM);
        printf("\nAverage of the elements = %f",(float)SUM/(float)NewSize);
    }
}
int* createDynamicArray(int size){
    int *Array;
    Array=(int *)(malloc(size*sizeof(int)));
    return Array;
    
}
void extendArray(int *arr,int size,int newSize){
    arr=(int*)realloc(arr,newSize*sizeof(int));
}