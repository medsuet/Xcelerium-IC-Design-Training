#include <stdio.h>

void swap(int *a, int *b) {
    // TODO: Implement swap function
    int temp = *a;
    *a = *b;
    *b = temp;
}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    int *start = arr ;
    int *end = arr + size -1;
    while ( start < end){
        swap(start , end);
        start++;
        end--;
    }

}


int main(){
    int num1 = 5;
    int num2 = 9;
    int sum;
    int *ptr = &num1;
    int arr[5] = {1, 2, 3, 4, 5};
    int *parr = arr;
    int len = sizeof(arr)/ sizeof(arr[0]);

    printf("the value of num1 is %d.\n",num1);
    printf("the value of ptr is %d.\n", *ptr);
    *ptr = 7;
    printf("the update value of num1 is %d.\n",num1);

    printf("the value of num1 and num2 before swap is %d and %d.\n",num1,num2);
    swap(ptr , &num2);
    printf("the value of num1 and num2 before swap is %d and %d.\n",num1,num2);

    printf("Original array: {");
    for (int i = 0; i < len; i++) {
        printf("%d ", arr[i]);
        sum = sum + arr[i];
    }
    printf("}\n");
    printf("sum of array is %d.\n", sum);

    reverseArray(arr, len);

   printf("Reverse array:  {");
   for (int i = 0; i < len; i++) {
       printf("%d ", arr[i]);
   }
   printf("}\n");

    return 0;
}

