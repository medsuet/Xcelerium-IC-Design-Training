#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

//following function takes 2's compliment of a number
int towsCompliment(int a) {
    a = ~a + 1;  //taking 2's compliment
    return a;
}
//following function adds two numbers
int add(int a, int b) {
    return a + b;
}
//following function perform arithmetic right shift operation
void arithmeticRightShift (int *accumulator, int *multiplier) {
    __int64_t temp;  //making temporary variable for concatination of numbers 
    temp = (__int64_t)*accumulator << 32;  //type casting accumulator value to 64b and perform right shift to make it as msb of temp variable 
    temp = temp | (__uint32_t)*multiplier; // make 32b msb accumulator and 32 lsb multiplier (combining bits)
    temp = temp >> 1; //performing left shift 

    *accumulator = temp >> 32 & 0xFFFFFFFF;   //updating value of accumulator    
    *multiplier = temp & 0xFFFFFFFF;    //updating value of multiplier
}

//following function perfom multiplication using booth algorithm
__int64_t boothMultiplier(int multiplier, int multiplicand) {
    __int64_t product;
    int accumulator = 0;
    int Q_1 = 0;
    int multiplierLSB;

    for (int count=0; count<32; count++) {
        multiplierLSB = multiplier & 1; //extracting multiplier lsb 
        if ((multiplierLSB==1 && (Q_1==0))) {
            accumulator = add(accumulator,towsCompliment(multiplicand)); //A=A-M if multiplier lsb and Q-1 bit is 1 0 
        }
        else if ((multiplierLSB==0 && (Q_1==1))) {
            accumulator = add(accumulator,multiplicand); //A=A+M if multiplier lsb and Q-1 bit is 0 1 
        }
        Q_1 = multiplierLSB;  //making Q-1 bit, lsb of multiplier is Q-1 bit
        arithmeticRightShift(&accumulator, &multiplier);  //performing arithmetic right shift
    }
    product = (__int64_t)accumulator << 32;     
    product = product | (__uint32_t)multiplier; //making product from accumulator and multiplier 
    return product;
}

//following function takes inputs from file and check booth multiplier
void testBoothMultiplierWithFile(const char* filename) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        //printf("Error in file opening\n");
        return;
    }
    __int64_t check;
    int multiplicand, multiplier;
    __int64_t product;
    for (int i = 0; i < 1000; i++) {
    //while (file != NULL) { 
        if (file != NULL) {
            fscanf(file, "%d %d %ld", &multiplicand, &multiplier, &product); //taking values from input file 
            //printf("%d %d %ld\n", multiplicand, multiplier, product);
            check = boothMultiplier(multiplicand,multiplier);  //checking multiplier
            if (check == product) {
                //printf("\nPassed");
            }
            else {
                //printf("\nFailed");
            }
        }
    }
    fclose(file);
}


//following function takes inputs from file and check booth multiplier
void testBoothMultiplier() {
    srand(time(NULL));
    __int64_t check;
    int multiplicand, multiplier;
    __int64_t product;
    for (int i = 0; i < 1000; i++) {
        multiplicand = (rand() << 1 | 1); 
        multiplier   = (rand() << 1 | 1);
        product = (int64_t)multiplier * (int64_t)multiplicand;
        //printf("%d X %d = %ld",multiplicand,multiplier,product);

        check = boothMultiplier(multiplicand,multiplier);  //checking multiplier
        if (check == product) {
            printf("Passed\n");
        }
        else {
            printf("Failed\n");
        }
    }
}
    


int main() {
    //testing from file
    // const char* filename = "32b_signed_test_inputs.txt";
    // testBoothMultiplierWithFile(filename);
    
    //testing using random
    testBoothMultiplier();

}

