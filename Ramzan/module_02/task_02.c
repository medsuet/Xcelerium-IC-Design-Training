#include<stdio.h>
#include <stdlib.h>
#include <time.h>

//Part 2: Pointers and Arrays
//Task 2.1


/*

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Initialize matrix with random values
    srand(time(0));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 100; // Assign random values between 0 and 99
        }
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Print the matrix
    printf("Our Matrix is:\n");
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Find and return the maximum element in the matrix
    int max = matrix[0][0];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] > max) {
                max = matrix[i][j];
            }
        }
    }
    return max;
}

int main() {
    int rows = 2;
    int cols = 3;
    int arr[rows][cols];

    initializeMatrix(rows, cols, arr);
    printMatrix(rows, cols, arr);

    int max = findMaxInMatrix(rows, cols, arr);
    printf("Max Element is: %d\n", max);

    return 0;
}

*/




//Task 2.2

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Initialize matrix with random values
    srand(time(0));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 100; // Assign random values between 0 and 99
        }
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Print the matrix
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int sumRow(int cols, int *row) {
    int sum = 0;
    for (int i = 0; i < cols; i++) {
        sum += row[i];
    }
    return sum;
}

int main() {
    int rows = 2;
    int cols = 3;
    int arr[rows][cols];

    initializeMatrix(rows, cols, arr);
    printMatrix(rows, cols, arr);

    for (int i = 0; i < rows; i++) {
        int sum = sumRow(cols, arr[i]);
        printf("Sum of row %d is: %d\n", i, sum);
    }

    return 0;
}

