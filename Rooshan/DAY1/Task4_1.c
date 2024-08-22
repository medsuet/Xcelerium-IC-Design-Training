#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main() {
    int c;
    printf("Prime Numbers in the range 1 to 100:\n");
    for(int i=1;i<=100;i++){
        c=0;
        for (int j=1;j<=i;j++){
            if (i%j==0){
                c+=1;
            }
        }
        if (c==2){
            printf("%d ",i);   
        }
    }
}
