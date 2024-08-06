/*
 * File: Lab1.c
 * Author: Misbah Rani
 * Date: 2024-07-06
 * Description: This file contains the implementation of tasks of Lab Experiment. 1 related to
 *              basics of C language.
 */


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "lab1_functions.c" 


int main() {
    srand(time(NULL));

    printf("Part 0: Quick Revision Exercises\n");

    // 0.1 Basic Syntax and Data Types
    printf("\n0.1. Printing the sizes: \n");
    int i = 5;
    float f = 3.56;
    double d =  4.67876;
    char c = 'm';
    printSizes(i, f, d, c);

    // 0.2 Operators and Expressions
    printf("\n0.2. Simple Calculator: \n");
    simpleCalculator();

    // 0.3 Control Structures
    printf("\n0.3.1. Fibonacci numbers: \n");
    int n;
    printf("Enter the number of Fibonacci terms to print: ");
    scanf("%d", &n);
    printFibonacci(n);

    printf("\n0.3.2. Guessing Game: \n");
    guessingGame();

    // 0.4 Functions
    printf("\n0.4.1. Prime Numbers Function: \n");
    printf("Prime numbers between 1 and 100:\n");
    for (int i = 1; i <= 100; i++) {
        if (isPrime(i)) {
            printf("%d ", i);
        }
    }
    printf("\n");
    
    printf("\n0.4.2. Factorial Function: \n");
    printf("Enter a number to calculate factorial: ");
    scanf("%d", &n);
    printf("Factorial of %d: %d\n", n, factorial(n));

    // 0.5 Arrays and Strings
    printf("\n0.5.1. String Reversal Function: \n");
    char str[] = "Hello, World!";
    printf("Original string: %s\n", str);
    reverseString(str);
    printf("Reversed string: %s\n", str);

    printf("\n0.5.2. Second Largest Number Function: \n");
    int arr[] = {5, 2, 8, 1, 9, 3, 7};
    int size = sizeof(arr) / sizeof(arr[0]);
    printf("Array elements: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    printf("Second largest element: %d\n", secondLargest(arr, size));

    return 0;
}


