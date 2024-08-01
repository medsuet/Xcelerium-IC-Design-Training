/*
    Name: main.c
    Author: Muhammad Tayyab
    Date: 10-7-2024
    Description: Function for use in task 5. Calculates and prints squareroot of 64.
*/

#include <stdio.h>
#include "functions.h"

int main(void) {
    double value = 64.00;
    double root = squareroot(value);
    printf("Square root of %f is %f.\n",value,root);
    return 0;
}