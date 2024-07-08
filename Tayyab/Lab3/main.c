#include <stdio.h>
#include "functions.h"

int main(void) {
    double value = 64.00;
    double root = squareroot(value);
    printf("Square root of %f is %f.\n",value,root);
    return 0;
}