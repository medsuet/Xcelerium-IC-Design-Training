#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <stdio.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // TODO: Declare variables of different types and print their sizes
int a;
float b;
double c;
char d;

printf("Size of int: %zu bytes\n",sizeof(a));
printf("Size of float: %zu bytes\n",sizeof(b));
printf("Size of double: %zu bytes\n",sizeof(c));
printf("Size of char: %zu bytes\n",sizeof(d));
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    // TODO: Implement a simple calculator using switch statement
char operation;
int operand1,operand2;

printf("\nEnter operation (+,-,*,/,%%): ");
scanf("%s",&operation);
printf("\nEnter first number: ");
scanf("%d",&operand1);
printf("\nEnter second number: ");
scanf("%d",&operand2);


    switch(operation)
    {
        case '+':
            printf("Sum: %d \n", (operand1+operand2));
            break;

        case '-':
            printf("Subtract: %d \n", (operand1-operand2));
            break;

        case '*':
            printf("Product: %d \n", (operand1*operand2));
            break;

        case '/':
            printf("Division: %f \n", ( ((float) operand1) / ((float) operand2) ));
            break;

        case '%':
            printf("Remainder: %d \n", (operand1%operand2));
            break;

    }
}

int calculateFibonacci(int n){
    if (n == 0)
    {
        return 0;
    }
    else if (n == 1)
    {
        return 1;
    }
    else
    {
        return (calculateFibonacci(n-1) + calculateFibonacci(n-2));
    }
}

// 0.3 Control Structures
void printFibonacci(int n) {
    printf("Fibonacci of %d is: %d \n", n, calculateFibonacci(n));
}

void guessingGame() {
    // TODO: Implement a number guessing game
//    int lower = 1;
//    int upper = 100;
    int num,guess;

    num = (rand() % (100-1+1))+1;
    // num = (rand() % (upper - lower + 1)) + lower;
    printf("Computer has succesfully guessed a random number from %d to %d \n",1,100);

    while (1)
    {
        printf("\nGuess a number: ");
        scanf("%d",&guess);

        if (guess == num)
        { 
            printf("The guessed number matched!\n");
            break;
        }
        else if (guess > num)
        {
            printf("Wrong! Guess lower!");
        }
        else
        {
            printf("Wrong! Guess higher!");
        }
    }
}

// 0.4 Functions
int isPrime(int num) {
    // TODO: Check if a number is prime
    int i;
    
    if ((num == 2) || (num == 1))
    {
        return 1; // is prime
    }

    if (num % 2 == 0)
    {
        return 0; // is not prime
    }

    for (i=3; (i <= ((int) (num/2))); (i += 2)) // will check prime by dividing with odd numbers only
    {
        if ((num % i) == 0)
        {
            return 0; // is not prime
        }
    }

    return 1; // is prime
}


int factorial(int n) {
    // TODO: Calculate factorial recursively
    if (n==1)
    {
        return n;
    }
    else
    {
        return (n * factorial(n-1));
    }
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    // TODO: Reverse a string in-place

    int length = 0;
    char *start = str;
    char *end = str;
    char temp;

    // Find the length of the string
    while (*end != '\0') {
        end++;
        length++;
    }
    
    // Move the end pointer one step back to point to the last character
    end--;

    // Swap the characters from start and end
    while (start < end) {
        temp = *start;
        *start = *end;
        *end = temp;
        start++;
        end--;
    }
}

int secondLargest(int arr[], int size) {
    // TODO: Find and return the second largest element in the array

    int first = arr[0], second = -1;
    
    // Initialize first and second based on the first two elements
    for (int i = 1; i < size; i++) {
        if (arr[i] != first) {
            second = arr[i];
            if (arr[i] > first) {
                second = first;
                first = arr[i];
            }
            break;
        }
    }
}

int main() {
    srand(time(NULL));

    printf("Part 0: Quick Revision Exercises\n");

    printf("\n Printing Sizes \n");

    // 0.1 Basic Syntax and Data Types
    printSizes();

    printf("\n Simple Calculator \n");

    // 0.2 Operators and Expressions
    simpleCalculator();

    // 0.3 Control Structures

    printf("\n To print Fibonacci \n");

    int n;
    printf("Enter the number of Fibonacci terms to print: ");
    scanf("%d", &n);
    printFibonacci(n);

    printf("\n Starting the Guessing Game\n");

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


    return 0;
}
