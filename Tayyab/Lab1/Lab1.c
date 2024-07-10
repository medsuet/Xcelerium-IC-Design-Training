/*
    Name: Lab1.c
    Author: Muhammad Tayyab
    Date: 10-7-2024
    Description: Tasks of Lab 1
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // TODO: Declare variables of different types and print their sizes
    short s; int i; char c; double d; long l; float f; unsigned short int usi;

    printf("SIZES: short:%lu\tint:%lu\tchar:%lu\tdouble:%lu\tlong:%lu\tfloat:%lu\tushortint:%lu\n", sizeof(short), sizeof(int), sizeof(char), sizeof(double), sizeof(long), sizeof(float), sizeof(unsigned short int));

}

// 0.2 Operators and Expressions
void simpleCalculator() {
    // TODO: Implement a simple calculator using switch statement
    // Inputs an expression with 2 numbers and 1 operator e.g (3+2) 
    // and prints the result.

    int a,b,result;
    char op;
    printf("Expression: ");
    scanf("%d %c %d", &a, &op, &b);

    switch (op) {
        case '+': result = a+b; break;
        case '-': result = a-b; break;
        case '*': result = a*b; break;
        case '/': result = a/b; break;
        case '%': result = a%b; break;
    }
    printf("= %d \n",result);
}

// 0.3 Control Structures
void printFibonacci(int n) {
    // Print Fibonacci sequence up to n terms
    int Tk=1, prevTk=1, nextTk;
    printf("1, 1");
    for (int i=1; i<=n; i++) {
        nextTk = Tk + prevTk;
        prevTk = Tk;
        Tk = nextTk;
        printf(", %d",Tk);
    }
    printf("\n");
}

void guessingGame() {
    // TODO: Implement a number guessing game

    // generate a random number between 0 and 100
    int secretnum = rand() % 101;
    int guessnum;
    
    printf("There is a secret number between 0 and 100 (inc)\n");

    // loop until correct number guessed
    do {
        // input guess
	    printf("Guess number: ");
	    scanf("%d",&guessnum);

        // give hint
	    if (guessnum<secretnum) {printf("Try a larger number\n\n");}
	    else if (guessnum>secretnum) {printf("Try a smaller number\n\n");}
    }while (guessnum != secretnum);
    
    printf("Correct guess\n");

}

// 0.4 Functions
int isPrime(int num) {
    // TODO: Check if a number is prime
    // Returns -1 (prime) or 0 (not prime)
    
    int prime;  // flag to store prime or not

    // 1 is not prime
    prime = num==1 ? 0:-1;

    // check all numbers from 2 till num. If num is divisible by any 
    // number in this range, it is not prime (else it is).
    for (int i=2; i<num; i++) {
	    if (num % i == 0) {
		prime = 0;
	    	break;
	    }
    }  
    return prime;
}

int factorial(int n) {
    // TODO: Calculate factorial recursively

    if (n==1) return 1;
    else return n * factorial(n-1);
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    // TODO: Reverse a string in-place
    int i;
    char temp;
    int len = strlen(str);

    // swap characters 1st with last, 2nd with 2nd last and so o
    for (i=0;i<len/2;i++) {
    	temp = str[i];
	    str[i] = str[len-1 - i];
	    str[len-1 - i] = temp;
    }
}

int secondLargest(int arr[], int size) {
    // TODO: Find and return the second largest element in the array
    
    int max=arr[0], max2nd;
    int i;
    
    for (i=1; i<size; i++) {
        // if we find an number greater than current max, current max becomes the second max
        if (arr[i]>max) {
            max2nd = max;
            max = arr[i];
	    }   
    }

   return max2nd;

}


int main() {
    srand(time(NULL));

    // Run and demonstrate functions defined above

    printf("Part 0: Quick Revision Exercises\n");

    // 0.1 Basic Syntax and Data Types
    printSizes();

    // 0.2 Operators and Expressions
    simpleCalculator();

    // 0.3 Control Structures
    int n;
    printf("Enter the number of Fibonacci terms to print: ");
    scanf("%d", &n);
    printFibonacci(n);

    guessingGame();

    // 0.4 Functions
    printf("Prime numbers between 1 and 100:\n");
    for (int i = 1; i <= 100; i++) {
        if (isPrime(i)) {
            printf("%d ", i);
        }
    }
    printf("\n");

    printf("Factorial of 5: %d\n", factorial(5));

    // 0.5 Arrays and Strings
    char str[] = "Hello, World!";
    printf("Original string: %s\n", str);
    reverseString(str);
    printf("Reversed string: %s\n", str);

    int arr[] = {5, 2, 8, 1, 9, 3, 7};
    int size = sizeof(arr) / sizeof(arr[0]);
    printf("Second largest element: %d\n", secondLargest(arr, size));

    // Parts 1-4: Advanced Pointer Concepts
    printf("\nAdvanced Pointer Concepts\n");
    // TODO: Implement and call functions for Parts 1-4 as in the previous template

    return 0;
}
