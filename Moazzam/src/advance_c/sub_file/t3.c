#include <stdio.h>

void swap(int *a, int *b) {
    // TODO: Implement swap function
    int temp = *a;
    *a = *b;
    *b = temp;
}

void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
    for(int i=0; i<size-1 ; i++ ){
        for(int j=0; j<size-i-1; j++){
            if (*(arr+j) > *(arr+j+1)){
                swap(arr+j,arr+j+1);
            }
            
        }
    }
}

void SelectionSort(int *arr, int size) {
    // TODO: Implement bubble sort
    for(int i=0; i<size-1 ; i++ ){
        int min_index = i;
        for(int j=i+1; j<size; j++){
            if (*(arr+min_index) > *(arr+j)){
                min_index = j;
            }    
        }
        swap(arr+i,arr+min_index);
    }
}

void (*SortFunction)(int*, int);
int (*OperationFunction)(int,int);

// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }


int main(){
    int arr[] = {8,1, 6, 10, 4, 5};
    int arr2[] = {8,1, 6, 10, 4, 5};
    int arr3[] = {8,1, 6, 10, 4, 5};
    int len = sizeof(arr)/ sizeof(arr[0]);

    printf("Original array: {");
    for (int i = 0; i < len; i++) {
        printf("%d ", arr[i]);
    }
    printf("}\n");

    bubbleSort(arr, len);

    printf("BubbleSort array:  {");
    for (int i = 0; i < len; i++) {
        printf("%d ", arr[i]);
    }
    printf("}\n");

    SelectionSort(arr2, len);

    printf("SelectionSort array:  {");
    for (int i = 0; i < len; i++) {
        printf("%d ", arr2[i]);
    }
    printf("}\n");

    
    SortFunction = bubbleSort;
    SortFunction(arr3,len);
    printf("function pointer array:  {");
    for (int i = 0; i < len; i++) {
        printf("%d ", arr3[i]);
    }
    printf("}\n");

    int x,y;
    char operation;

    //inputs
    printf("which Operation do you want to do: ");
    scanf("%c", &operation);
    printf("Enter 1st Number: ");
    scanf("%d", &x);
    printf("Enter 2nd Number: ");
    scanf("%d", &y);

    //part2
    switch (operation)
    {
    case '+':
        OperationFunction = add;
        printf("Addition of number is: %d\n", OperationFunction(x,y));
        break;

    case '-':
        OperationFunction = subtract;
        printf("Subtraction of number is: %d\n", OperationFunction(x,y));
        break;

    case '*':
        OperationFunction = multiply;
        printf("Multiplication of number is: %d\n", OperationFunction(x,y));
        break;

    case '/':
        OperationFunction = divide;
        printf("Division of number is: %d\n", OperationFunction(x,y));
        break;
    
    default:
        printf("input operation is invalide.\n");
        break;
    }

    return 0;
}