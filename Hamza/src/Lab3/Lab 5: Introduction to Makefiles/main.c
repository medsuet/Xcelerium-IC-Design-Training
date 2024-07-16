// main.c
#include <stdio.h>
#include "functions.h" // Include the header file

int main() {
    int a = 5;
    int b = 10;
    int sum = add(a, b);
    int diff = subtract(a, b);

    printf("Sum: %d\n", sum);
    printf("Difference: %d\n", diff);

    return 0;
}
