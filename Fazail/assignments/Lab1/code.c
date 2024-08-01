#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <limits.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // TODO: Declare variables of different types and print their sizes
    int x = 10;
    char y = (char)x;
    float z = (float)x;
    double w = (double)x;
    printf("Size of x = %zu\n", sizeof(x));
    printf("Size of y = %zu\n", sizeof(y));
    printf("Size of z = %zu\n", sizeof(z));
    printf("Size of w = %zu\n", sizeof(w));
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    // TODO: Implement a simple calculator using switch statement
    // user inputs
    int x;
    int y;
    printf("Input x = ");
    scanf("%d", &x);
    printf("Input y = ");
    scanf("%d", &y);
    
  // switch operatoion variable 
    int opr;
    printf("Values of operator\n");
    printf(" add      => 1\n subtract => 2\n");
    printf(" multiply => 3\n divide   => 4\n");
    printf(" mod      => 5\n");
    printf("Type the value of operator: ");
    scanf("%d", &opr);
    
  // switch statement
    switch (opr) { 
       case (1):
       	   printf("Add the user inputs = %d\n", x+y);
       	   break;
       case (2):
       	   printf("Subtract the user inputs = %d\n", x-y);
       	   break;
       case (3):
           printf("Multiply the user inputs = %d\n", x*y);
           break;
       case (4):
       	   printf("Divide the user inputs = %d\n", x / y);
       	   break;
       case (5):
       	   printf("Mod of the user inputs = %d\n", x % y);
       	   break;
    }
}

// 0.3 Control Structures
void printFibonacci(int n) {
    // TODO: Print Fibonacci sequence up to n terms
    // initialize the values
	 int term1 = 0; 	// 1st term
	 int term2 = 1;		// 2nd term
	 int next_term = term1 + term2;
	 int i;
	 
	 printf("Print the 2nd to %dth terms\n", n); 
	 for (i=0; i<(n-1); i++){
	     printf("%d, ", next_term);
	     next_term = term1 + term2;
	     term1 = term2;
	     term2 = next_term;
	 }
}

void guessingGame() {
    // TODO: Implement a number guessing game
    srand(time(NULL));
    int rand_value; //random Value
    int user_input; //user input

    rand_value = (rand() % 100 + 1);

    printf("\nType the initial guess:", rand_value);
    scanf("%d", &user_input);

    while(user_input != rand_value)
    {
        if (user_input < rand_value) {
            printf("Your guess is low\n");
            printf("Guess a new value:");
	    scanf("%d", &user_input); }
        else {
	    printf("Your guess is high\n");
	    printf("Guess a new value:");
	    scanf("%d", &user_input);}
    }
    printf("Your Value matched. CONGRATULATIONS!!!\n");
 }

// 0.4 Functions
int isPrime(int num) {
    // TODO: Check if a number is prime
    if (num <= 1) return 0;
    if (num == 2) return 1; // 2 is the only even prime number
    if (num % 2 == 0) return 0; // Other even numbers are not primes

    for (int i = 3; i * i <= num; i += 2) {
        if (num % i == 0) return 0;
    }
    return 1;
}

int factorial(int n) {
    // TODO: Calculate factorial recursively
    if (n == 0 || n == 1) {
        return 1; // Base case: 0! = 1 and 1! = 1
    }
    return n * factorial(n - 1); // Recursive case
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    // TODO: Reverse a string in-place
    int start = 0;
    int end = sizeof(str) - 1;
    char temp;

    while (start < end) {
        // Swap characters
        temp = str[start];
        str[start] = str[end];
        str[end] = temp;

        // Move indices towards the center
        start++;
        end--;
    }
}

int secondLargest(int arr[], int size) {
    // TODO: Find and return the second largest element in the array
    if (size < 2) {
        printf("Array must have at least two elements.\n");
        return INT_MIN; // Return a special value indicating error
    }

    int firstLargest = INT_MIN;
    int secondLargest = INT_MIN;

    for (int i = 0; i < size; i++) {
        if (arr[i] > firstLargest) {
            secondLargest = firstLargest;
            firstLargest = arr[i];
        } else if (arr[i] > secondLargest && arr[i] != firstLargest) {
            secondLargest = arr[i];
        }
    }

    if (secondLargest == INT_MIN) {
        printf("There is no second largest element.\n");
        return INT_MIN; // Return a special value indicating error
    }

    return secondLargest;
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

    // Parts 1-4: Advanced Pointer Concepts
    printf("\nAdvanced Pointer Concepts\n");
    // TODO: Implement and call functions for Parts 1-4 as in the previous template

    return 0;
}

