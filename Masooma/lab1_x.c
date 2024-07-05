// Description: Xcelerium Training Lab 1 --C language
// Author: Masooma Zia
// Date: 01-07-2024

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
//Function is used to print sizes of different datatypes and modifiers. It also typecasts different datatypes
void printSizes() {
    int num_int;
    float num_float;
    double num_double;
    char character;
    short int short_int;
    long int long_int;
    unsigned int uns_int;
    signed int s_int;
    printf("Size of integer %ld",sizeof(num_int));
    printf("\n");
    printf("Size of float %ld",sizeof(num_float));
    printf("\n");
    printf("Size of double %ld",sizeof(num_double));
    printf("\n");
    printf("Size of character %ld",sizeof(character));
    printf("\n");
    printf("Size of short integer %ld",sizeof(short_int));
    printf("\n");
    printf("Size of long integer %ld",sizeof(long_int));
    printf("\n");
    printf("Size of unsigned integer %ld",sizeof(uns_int));
    printf("\n");
    printf("Size of signed integer %ld",sizeof(s_int));
    printf("\n");

    short int float_new;
    int double_new;
    double int_new;
    float_new = (short int) num_float;
    printf("Size of typecasting of float %ld",sizeof(float_new));
    printf("\n");
    double_new = (int) num_double;
    printf("Size of typecasting of double %ld",sizeof(double_new));
    printf("\n");
    int_new = (double) num_int;
    printf("Size of typecasting of integer %ld",sizeof(int_new));
    printf("\n");
}
// 0.2 Operators and Expressions
//Function is used to calculate arithmetic operations like addition, subtraction, multiplication, division and remainder of two integers and
// and operation entered by user. It also displays the result on terminal
void simpleCalculator() {
    int num1;
    int num2;
    char opr;
    int sum, minus, product, divide, reminder;
    printf("Enter the first number:");
    scanf("%d",&num1);
    printf("Enter the second number:");
    scanf("%d",&num2);
    printf("Enter the operation:");
    while (getchar() != '\n');  // Flush the input buffer to avoid issues with newline characters
    scanf("%c",&opr); // Use %c to read a single character
    printf("\n");
    switch (opr){
        case 'A':
            sum = num1+num2;
            printf("Sum %d\n",sum);
            break;
        case 'S':
            minus = num1-num2;
            printf("Subtraction %d\n",minus);
            break;
        case 'P':
            product = num1*num2;
            printf("Product %d\n",product);
            break;
        case 'D':
            divide = num1/num2;
            printf("Division %d\n",divide);
            break;
        case 'R':
            reminder = num1%num2;
            printf("Reminder %d\n",reminder);
            break;
    }
}

// 0.3 Control Structures
//Function is used to print the fibonacci series till the number of terms entered by user
void printFibonacci(int n) {
    int first_num=0;
    int second_num=1;
    int next_num;
    printf("%d\n",first_num);
    printf("%d\n",second_num);
    for (int i=0;i<n-2;i++){
        next_num=first_num+second_num;
        printf("%d\n",next_num);
        first_num=second_num;
        second_num=next_num;
    }
    
}
// A guessing game to guess an integer between 0 and 10. Guess entered by user checks corresponding to the random number generated at that time 
// and according to the difference between guess and random number it gives a status of lower or higher to help in guessing
void guessingGame() {
    int rnd_num;
    int guess;
    srand(time(NULL));
    rnd_num=rand()%11;
    printf("Enter your guess:");
    scanf("%d",&guess);
    while (guess!=rnd_num){
        if (guess<rnd_num) {
            printf("Higher\n");
            printf("Enter your guess:");
            scanf("%d",&guess);
        }
        else{
            printf("Lower\n");
            printf("Enter your guess:");
            scanf("%d",&guess);
        }
    }
    printf("Success!!!\n");
}

// 0.4 Functions
//Function used to determine whether the number entered by user is prime or not
int isPrime(int num) {
    int flag=0;
    for (int i = 2;i <= num/2;i++){
        if ((num % i == 0)){
            flag += 1;
        }
        else {
            continue;
        }
    }
    if ((flag != 0)|(num==1)){
        return 0;
    }
    else {
        return 1;
    }
}

//Function is used to caculate factorial of a number entered by user
int factorial(int n) {
    if ((n==0) | (n==1)){
        return 1;
    }
    else {
        return n*factorial(n-1);
    }
}

// 0.5 Arrays and Strings
//Function used to reverse the string given to it as argument
void reverseString(char* str) {
    int temp;
    int length = strlen(str);
    for (int i = 0;i<length/2;i++){
        temp=str[i];
        str[i]=str[length-i-1];
        str[length-i-1]=temp;
    }
}
//Function used to find out the second highest number in an array
int secondLargest(int arr[], int size) {
    int temp=0;
    int temp1=0;
    for (int i = 0; i < size; i++){
        if (arr[i] > temp){
            temp = arr[i];
        }
        else{}
    }
    for (int i = 0; i < size; i++){
        if ((arr[i] > temp1) & (arr[i]!=temp)){
            temp1=arr[i];
        }
        else {}
    }
    return temp1;
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
    
    printf("\nFactorial of 5: %d\n", factorial(5));

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
