#include <stdio.h>
#include <stdlib.h>

int main() {
    int i;
    int n;
    printf("Enter the value of n(Number of terms of the fibonacci sequence)\n");
    scanf("%d",&n);
    int fibonacci_sequence[n];

    for(i=0;i<n;++i){
        if (i!=0 && i!=1){
            fibonacci_sequence[i]=fibonacci_sequence[i-1]+fibonacci_sequence[i-2];
                printf(",%d",fibonacci_sequence[i]);
        }
        else{
            if (i==0){
                fibonacci_sequence[i]=0;
                printf("%d",fibonacci_sequence[i]);
            }
            else if(i==1){
                fibonacci_sequence[i]=1;
                printf(",%d",fibonacci_sequence[i]);
            }
                
            }
    }
    
}