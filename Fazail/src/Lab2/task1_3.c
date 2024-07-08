#include <stdio.h>

int main()
{
    int arr[] = {2,4,6,8,10};     //initialize the array of 5 integers
    int *ptr_arr = arr;           //array pointer
    int arr_size = sizeof(arr)/sizeof(int); 
    int elements;		 //array elements
    int add_arr_el = 0;		 //add elements of array variable
    int temp_arr[arr_size];	 	 //temporary array use in reversing the array

//    temp_arr = arr;

    printf("Size of array: %d\n", arr_size);

    printf("Print the elements of array: ");
    for(int i=0; i<arr_size; i++)
    {
	 elements = *(ptr_arr + i);
         printf("%d ", elements);	// print the elements of the array
 	 add_arr_el = add_arr_el + elements; // add all the elements of the array
    }
    printf("\n");
    printf("The sum of all the elements in the array is %d\n", add_arr_el);
   
    // Reverse the array in-place
    printf("Reverse of the array in place: ");
    for(int j=arr_size-1; j>=0; j--)
    {
	 temp_arr[j] = *(ptr_arr + j);
         printf("%d ", arr[j]);
    }
    printf("\n");
    return 0;
}
