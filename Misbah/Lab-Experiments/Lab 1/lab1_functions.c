#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Function declarations
void printSizes(int i, float f, double d, char c);
void simpleCalculator();
void printFibonacci(int n);
void guessingGame();
int isPrime(int num);
int factorial(int n);
void reverseString(char* str);
int secondLargest(int arr[], int size);

// 0.1 Basic Syntax and Data Types
void printSizes(int i, float f, double d, char c) {
    printf("Size of Integer: %ld \n", sizeof(i) );
    printf("Size of Float: %ld \n" , sizeof(f) );
    printf("Size of Double: %ld \n", sizeof(d) );
    printf("Size of Character: %ld \n", sizeof(c) );

    int int_cast;
    int_cast = (int)f;
    printf("%d \n", int_cast);

    double double_cast;
    double_cast = (double)f;
    printf("%f \n", double_cast);
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    int a, b, Add, Sub, Multi, Div;
    char op;

    printf("Enter 1st number: ");
    scanf("%d" , &a);
    printf("\nEnter 2nd number: ");
    scanf("%d", &b);

    Add = a+b;
    Sub =  a-b;
    Multi = a*b;
    Div = a/b;
    printf("\nEnter the sign for the operation to perform: ");
    scanf(" %c", &op);
    
    switch(op){
    case '+':
    printf("The above numbers are added to give: %d\n", Add);
    break;
    case '-':
    printf("The above numbers are subtracted to give: %d\n", Sub);
    break;
    case '*':
    printf("The above numbers are multiplied to give: %d\n", Multi);
    break;
    case '/':
    printf("The above numbers have the quotient: %d\n", Div);
    break;
   }
}

// 0.3 Control Structures
void printFibonacci(int n) {
    int a1 = 0, a2 = 1, next;
    printf("Fibonacci Sequence: ");
    for (int i = 1; i <= n; ++i) {
        printf("%d ", a1);
        next = a1 + a2;
        a1 = a2;
        a2 = next;
    }
    printf("\n");
}

void guessingGame() {
    int random, guess;
    random = rand() % 10 + 1;
    printf("Guess the number between 1 and 10: "); 
    do {
        scanf("%d", &guess);
        if (guess > random) {
            printf("It's high! Guess it again: ");
        } else if (guess < random) {
            printf("It's low! Guess it again: ");
        } else {
            printf("Congrats! You guessed it.\n");
        }
    } while (guess != random);
}

// 0.4 Functions
int isPrime(int num) {
    if(num<=1){
        return 0;
    }
    for (int i = 2; i<= num/2;  ++i){
        if (num % i  == 0) {
            return 0;
        }
    }
    return 1;
}

int factorial(int n) {
    if(n == 0){
        return 1;
    }
    return n * factorial(n-1);
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    int len = strlen(str);
    for(int i = 0; i < len/2; i++){
        char temp = str[i];
        str[i] = str[len - i - 1];
        str[len - i - 1] = temp;
    }
}

int secondLargest(int arr[], int size) {
    int largest =  arr[0];
    int secondlargest = arr[0];
    for(int i =  1; i < size; i++){
        if(arr[i] > largest){
            secondlargest = largest;
            largest = arr[i];
        }
        else if(arr[i] > secondlargest && arr[i] != largest){
            secondlargest = arr[i];
        }
    }
    return secondlargest;
}
