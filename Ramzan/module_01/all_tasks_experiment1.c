//Task 0.1: Basic Syntax and Data Types

//part(a)

#include<stdio.h>
#include <stdlib.h>
void printSizes(int a,float b,double c,char d);
int main()
{
    int x = 2;
    float y = 3.4;
    double z= 3.1234566;
    char zz = 'A';
    // TODO: Declare variables of different types and print their sizes
    printSizes(x,y,z,zz);
}
void printSizes(int a,float b,double c,char d) {
    printf("Size of an integer is:%zu\n",sizeof(a));
    printf("Size of an float is:%zu\n",sizeof(b));
    printf("Size of an double is:%zu\n",sizeof(c));
    printf("Size of an char is:%zu\n",sizeof(d));
    return 0;
}




//Task 0.2 Operators and Expressions
//part(a)
#include<stdio.h>

int main() {
    int x;
    int y;
    printf("Enter two numbers: ");
    scanf("%d %d", &x, &y);

    int sum = x + y;
    int sub = x - y;
    int mul = x * y;
    float div = (float)x / y; // Typecasting to float for accurate division result
    int mod = x % y;

    printf("Addition of %d and %d is: %d\n", x, y, sum);
    printf("Subtraction of %d and %d is: %d\n", x, y, sub);
    printf("Multiplication of %d and %d is: %d\n", x, y, mul);
    printf("Division of %d and %d is: %.2f\n", x, y, div); // Displaying float result with two decimal places
    printf("Modulo of %d and %d is: %d\n", x, y, mod);

    return 0;
}

//part(b)

#include <stdio.h>

int main() {
    int x, y, choice;
    printf("Enter two numbers: ");
    scanf("%d %d", &x, &y);
    printf("Enter your choice: ");
    scanf("%d", &choice);

    switch (choice)
    {
    case 1:
        printf("Addition of %d and %d is: %d\n", x, y, x + y);
        break;
    case 2:
        printf("Subtraction  of %d and %d is: %d\n", x, y, x - y);
        break;
    case 3:
        printf("Multiplication of %d and %d is: %d\n", x, y, x * y);
        break;
    case 4:
        if(y!=0)
        {
            printf("Division of %d and %d is: %f\n", x, y, (float)x/y);
        }
        else
        {
            printf("Cannot divide by zero.\n");
        }
    
    
    default:
        printf("Invalid Choice.\n");
        break;
    }
    return 0;
}




//Task-03

//part(a)

//Programme to find Fibbonacci Squence of numbers between 1 and 100;
#include<stdio.h>

int main()
{
    int num=10;
    int n1=0;
    int n2=1;
    int next_num;
    for(int i=0;i<10;i++)
    {
        printf("%d\n",n1);
        next_num = n1+n2;
        n1 = n2;
        n2 = next_num;
    }
    return 0;
}



#include<stdio.h>
//Task 0.4 Functions

//part(a)
//Programme to find prime number

int main()
{
    int i, j, isPrime;
    for(i = 2; i <= 100; i++)
    {
        isPrime = 1;
        for(j = 2; j < i; j++)
        {
            if(i % j == 0)
            {
                isPrime = 0;
                break;
            }
        }
        if(isPrime == 1)
        {
            printf("%d ", i);
        }
    }
    printf("\n");
    return 0;
}


//part(b)
//Programme to find Fictoril


int Fictorial(int num);

int main()
{
    int x;
    printf("Enter a number:");
    scanf("%d",&x);
    Fictorial(x);

}
int Fictorial(int num)
{
    int fic = 1;
    for (int i=1;i<=num;i++)
    {
        fic = fic*i;

    }
    printf("Fictorial is:%d\n",fic);
    return 0;
}


//Task 0.5 Arrays and Strings

//part(a)

#include<stdio.h>

int main()
{
    char name[50] = "MuhammadRamzan";
    char new_str[30];
    int len = strlen(name);
    for(int i=0;i<len;i++)
    {
        new_str[i] = name[len-1-i];
    }
    printf("Reveresed string is:%s\n",new_str);
    return 0;
}

//part(b)


#include <stdio.h>

int main() {
    int arr[] = {10, 20, 4, 45, 90}; // Predefined array
    int size = sizeof(arr) / sizeof(arr[0]);
    int max1, max2;

    // Initialize max1 and max2 to first two elements of the array
    max1 = arr[0];
    max2 = arr[1];

    // Find the first and second largest elements
    if (max2 > max1) {
        int temp = max1;
        max1 = max2;
        max2 = temp;
    }

    for (int i = 2; i < size; i++) {
        if (arr[i] > max1) {
            max2 = max1;
            max1 = arr[i];
        } else if (arr[i] > max2 && arr[i] != max1) {
            max2 = arr[i];
        }
    }

    // Print the second largest element
    printf("The second largest element in the array is: %d\n", max2);

    return 0;
}
