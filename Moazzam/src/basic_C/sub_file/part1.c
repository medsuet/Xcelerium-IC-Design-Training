#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int main() {
    // TODO: Declare variables of different types and print their sizes
    int n;
    float f;
    double d;
    char c;
    printf("Size of int is %zu bytes.\n",     sizeof(n));
    printf("Size of float is %zu bytes.\n",   sizeof(f));
    printf("Size of double is %zu bytes.\n",  sizeof(d));
    printf("Size of char is %zu bytes.\n",    sizeof(c));
    return 0;
}
