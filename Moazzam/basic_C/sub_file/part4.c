#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int isPrime(int num) {
    int b;
    for(int i=2; i<num ; i++){
        if(num%i == 0){ 
            b = 0;   
            break;       
        }
        else{
            b=1;
        }
    }
    return b;
}

int factorial(int n) {
    // TODO: Calculate factorial recursively
    if(n ==1){
        return 1;
    }
    else if (n == 2)
    {
        return 2;
    }
    else{
        return n*factorial(n-1);
    }
    
}

int main() {
    int n = 5;
    //printf("%d\n", n%2 );
    //printf("%d\n", n%3 );
    //printf("%d\n", n%4 );
    printf("%d \n", factorial(n));
    if(isPrime(n)==1){
        printf("number is prime\n");
    }
    else{
        printf("number is not prime\n");
    }
    //printf("%d\n", isPrime(n));
    return 0;
}