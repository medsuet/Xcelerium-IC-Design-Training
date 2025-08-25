#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // TODO: Declare variables of different types and print their sizes
    int n;
    float f;
    double d;
    char c;
    printf("Size of int is %zu bytes.\n",     sizeof(n));
    printf("Size of float is %zu bytes.\n",   sizeof(f));
    printf("Size of double is %zu bytes.\n",  sizeof(d));
    printf("Size of char is %zu bytes.\n",    sizeof(c));
    
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    // TODO: Implement a simple calculator using switch statement
    int x,y;
    char operation;

    //inputs
    printf("which Operation do you want to do: ");
    scanf("%c", &operation);
    printf("Enter 1st Number: ");
    scanf("%d", &x);
    printf("Enter 2nd Number: ");
    scanf("%d", &y);

    switch (operation)
    {
    case '+':
        printf("Addition of number is:       %d\n", x+y);
        break;

    case '-':
        printf("Subtraction of number is:    %d\n", x-y);
        break;

    case '*':
        printf("Multiplication of number is: %d\n", x*y);
        break;

    case '/':
        printf("Division of number is:       %d\n", x/y);
        break;
    
    default:
        printf("input operation is invalide.\n");
        break;
    }
}

// 0.3 Control Structures
void printFibonacci(int n) {
    // TODO: Print Fibonacci sequence up to n terms
   int f1 = 0; 
   int f2 = 1;
   int fnext = f1+f2; 
   
   printf("Fibonacci Series: %d, %d, ", f1, f2);

   for(int i=3; i <= n ; i++){
       printf("%d, ", fnext);
       f1 = f2;
       f2 = fnext;
       fnext = f1+f2;
   }
   printf("\n");   
}

void guessingGame() {
    // TODO: Implement a number guessing game
    int number;
    int r = (rand() % 100-1+1)+1;
    //rand() % (upper_bound - lower_bound + 1) + lower_bound; 

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

// 0.4 Functions
int isPrime(int num) {
    // TODO: Check if a number is prime
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



void reverseString(char* str) {
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


    // Traverse the array to find the first and second largest elements
    for (int i = 1; i < size; i++) {
        if (arr[i] > first) {
            second = first;
            first = arr[i];
        } else if (arr[i] > second && arr[i] != first) {
            second = arr[i];
        }
    }

    return second;
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