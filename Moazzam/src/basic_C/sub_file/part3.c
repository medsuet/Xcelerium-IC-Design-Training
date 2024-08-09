#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int main() {
    /*
    int n,i;
    int f1 = 0; 
    int f2 = 1;
    int fnext = f1+f2; 
    
    printf("Enter the number of terms of fibonacci number: ");
    scanf("%d", &n);

    printf("Fibonacci Series: %d, %d, ", f1, f2);

    for(i=3; i <= n ; i++){
        printf("%d, ", fnext);
        f1 = f2;
        f2 = fnext;
        fnext = f1+f2;
    }
    printf("\n");   
    */
    int number;
    srand(time(NULL));   
    int r = rand();
    //printf("%d \n",r);
    
    while (1)
    {
        printf("Guess the number: ");
        scanf("%d", &number);

        if(number == r) {
            printf("Number Guess is true.\n");
            break;
        }
        else if (number > r)
        {
            printf("try smaller number\n");
        }
        else if (number < r)
        {
            printf("try larger number\n");
        }
        
    }
    
}