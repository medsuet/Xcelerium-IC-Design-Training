#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>



int decimalToBinary(int num){
    // TODO: Convert Decimal Number to Binary

    if (num == 0)
    {
        return 0;
    }

    int binaryNum[32]; // assuming 32 bit integer at max


    while (num > 0)
    {
        binaryNum[i++] = num%2;
        num /= 2;
    }

    return binaryNum;
}

void printBinary(int binaryNum[]){
    // TODO: Print a 32 bit binary num

    