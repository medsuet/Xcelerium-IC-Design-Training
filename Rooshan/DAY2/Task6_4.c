#include <stdio.h>
#include <stdlib.h>
typedef union {
    int i;
    float f;
    char c;
}Data;
int main(){
    Data array[50];
    Data value;
    int num_elements;
    int Type;
    printf("Enter number of elements: ");
    scanf("%d",&num_elements);
    for(int index=0;index<num_elements;++index){
        printf("Enter the type of element for index %d (int(1),float(2),char(3)): ",index);
        scanf("%d",&Type);
        if (Type==1){
            printf("Enter the element for index %d: ",index);
            scanf("%d",&value.i);
            array[index].i=value.i;   
        }
        if (Type==2){
            printf("Enter the element for index %d: ",index);
            scanf("%f",&value.f);
            array[index].f=value.f;   
        }
        if (Type==3){
            printf("Enter the element for index %d: ",index);
            scanf(" %c",&value.c);
            array[index].f=value.c;   
        }
    }  
}
