#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    int x;
    float y;
    double z;
    char r;
    printf("Size of int: %zu \n", sizeof(x));
    printf("Size of float: %zu \n", sizeof(y));
    printf("Size of double: %zu \n", sizeof(z));
    printf("Size of char: %zu \n", sizeof(r));    

}

// 0.2 Operators and Expressions
void simpleCalculator(){
    int x, y;
    char op;
    printf("Enter oparend a: ");
    scanf("%d", &x);
    printf("Enter operand b: ");
    scanf("%d", &y);
    printf("Enter the operator (+, -, *, /): ");
    scanf(" %c", &op); // Note the space before %c to consume any leftover newline character
    switch(op) {
        case '+':
            printf("Ans : %d\n", x + y);
            break;
        case '-':
            printf("Ans : %d\n", x - y);
            break;
        case '*':
            printf("Ans :  %d\n", x * y);
            break;
        case '/':
            if (y == 0) {
                printf("Error: Division by 0\n");
            } else {
                printf("Ans : %f\n", (float)x / (float)y);          
            }
            break;
}
}

// 0.3 Control Structures
void printFibonacci(int n) {
    int a = 0;
    int b = 1;
    int c;
    printf("The Fibonacci Sequence up to %d terms:\n", n);
    for (int i = 1; i <= n; ++i) {
        printf("%d, ", a);
        c = a + b;
        a = b;
        b = c; 
    }
    printf("\n");
}

void guessingGame() {
    int number, guess, attempts = 0;
    number = rand() % 100 + 1; // Random number between 1 and 100
    do {
        printf("Guess the number: ");
        scanf("%d", &guess);
        attempts++;

        if (number > guess) {
            printf("The number is higher than the guess\n");
        } else if (number < guess) {
            printf("The number is lower than the guess\n");
        } else {
            printf("Correct! You guessed the number %d in %d attempts\n", number, attempts);
        }
    } while (guess != number);
}

// 0.4 Functions
int isPrime(int num) {
    if (num <= 1) return 0;
    for (int i = 2; i <= num / 2; i++) {
        if (num % i == 0) return 0;
    }
    return 1;
}

int factorial(int n) {
    if (n == 0) {
        return 1;
    } else {
        return n * factorial(n-1);
    }
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    char *start = str;
    char *end = str + strlen(str) - 1;
    char temp;
    while (end > start) {
        temp = *start;
        *start = *end;
        *end = temp;
        start++;
        end--;
    }
}

int secondLargest(int arr[], int size) {
    int l, sl;
    if (arr[0] < arr[1]) {
    	l = arr[1];
    	sl = arr[0];
    }
    else if (arr[0] > arr[1]) {
        l = arr[0];
    	sl = arr[1];
    }
    
    for (int i = 2; i < size; i++) {
        if (l < arr[i]) {
            sl = l;
            l = arr[i];
        } 
        else if ((arr[i] > sl) && (arr[i] < l)) {
            sl = arr[i];
        }
    }
    return sl;
}

int main() {
    srand(time(NULL));

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

    return 0;
}
