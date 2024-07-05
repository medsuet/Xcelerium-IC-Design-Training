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
