#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    // TODO: Implement swap function
    int ptr =*a;
       *a=*b;
       *b=ptr;
    
}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    int sum=0;
    int num;
    //int array[size];
    for(int i=0;i<size/2;i++){
       sum = sum + *(arr+i);
       num = *(arr+i);
  
       *(arr+i) = *(arr+((size-1)-i));
       
       *(arr+((size-1)-i))=num;
 
        
    }

    printf("sum is %d\n",sum);
    printf("reverse of array is ");
  for(int i=0;i<size;i++){
        printf("%d ",arr[i]);}
  printf("\n");
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Initialize matrix with random values
    for(int i=0;i<rows;i++){
         for(int j=0;j<cols;j++ ){
		 
	         matrix[i][j] = rand();   
	 }
    }
    
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
    printf("2d arrays is:\n");
    printf("{");
    for(int i=0;i<rows;i++){
            printf("{");
            for(int j=0;j<cols;j++){
                   printf("%d  ",matrix[i][j]);
            }
            printf("} ");
    }       
            printf("}");
            printf("\n");

}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
     int largest=matrix[0][0];
     for(int i=0;i<rows;i++){
            for(int j=0;j<cols;j++){
	        if( matrix[i][j]>largest){
		        largest=matrix[i][j];
		}
	    }
     }
     return largest;
}

void sumRows(int rows, int cols, int(*matrix)[cols]){
          int sum=0;
	  int largest=matrix[0][0];
     for(int i=0;i<rows;i++){
            for(int j=0;j<cols;j++){
                   sum=sum+matrix[i][j];
                        
                }
            printf("sum of %d row is %d\n",i,sum);
	    sum=0;
            }
     }
// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
    int num;
  for(int i=0;i<size;i++){
       for(int i=0; i<size; i++){
            if(i+1>=size) break;    
                 if(arr[i]>arr[i+1]){
         	        num = arr[i];

                        arr[i] = arr[i+1];
   
                        arr[i+1]=num;
                   
	       	//        for(int i=0; i<size; i++){
               //                 printf("%d ",arr[i]);
              //          }
	//	  printf("\n");
 	          }
      }
  }     
    printf("bubble sort array is\n ");
    for(int i=0; i<size; i++){
       printf("%d ",arr[i]);
    }
    printf("\n");
}

void selectionSort(int *arr, int size) {
    for (int i = 0; i < size - 1; i++) {
        // Find the minimum element in the unsorted part of the array
        int minIndex = i;
        for (int j = i + 1; j < size; j++) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }

        // Swap the found minimum element with the first element
        int temp = arr[minIndex];
        arr[minIndex] = arr[i];
        arr[i] = temp;
    }

    printf("Selection sorted array is: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

//part 4.1

// Define the structure for a node
struct Node {
    int data;
    struct Node* next;
};

// Function to insert a node at the beginning of the list
void insertAtBeginning(struct Node** head, int value) {
    struct Node* new_node = (struct Node*)malloc(sizeof(struct Node)); // Allocate memory for new node
    new_node->data = value; // Set the data
    new_node->next = *head; // Link the new node to the old head
    *head = new_node; // Update the head to the new node
}

// Function to delete a node by value
void deleteByValue(struct Node** head, int value) {
    struct Node* temp = *head;
    struct Node* prev = NULL;

    // If the head node itself holds the value to be deleted
    if (temp != NULL && temp->data == value) {
        *head = temp->next; // Change head
        free(temp); // Free old head
        return;
    }

    // Search for the value to be deleted, keep track of the previous node
    while (temp != NULL && temp->data != value) {
        prev = temp;
        temp = temp->next;
    }

    // If the value was not present in the list
    if (temp == NULL) {
        printf("Node with value %d not found.\n", value);
        return;
    }

    // Unlink the node from the linked list
    prev->next = temp->next;

    free(temp); // Free memory
}

// Function to print the linked list
void printList(struct Node* head) {
    if (head == NULL) {
        printf("List is empty.\n");
        return;
    }

    struct Node* current = head;
    while (current != NULL) {
        printf("%d -> ", current->data);
        current = current->next;
    }
    printf("NULL\n");
}

// part 4.2 




  
/* A linked list node */
struct Node 
{ 
    // Any data type can be stored in this node 
    void  data;
    struct Node *next;
};    
  
// Function to add a node at the beginning of Linked List. 
   
void push(struct Node** head_ref, void *new_data, size_t data_size) 
{ 
   
    struct Node* new_node = (struct Node*)malloc(sizeof(struct Node)); 
  
    new_node->data  = malloc(data_size); 
    new_node->next = (*head_ref); 
  
    // Copy contents of new_data to newly allocated memory. 
    
    int i; 
    for (i=0; i<data_size; i++) 
        *(char *)(new_node->data + i) = *(char *)(new_data + i); 
  
     
    (*head_ref)    = new_node; 
} 
  
/* Function to print nodes in a given linked list. fpitr is used 
   to access the function to be used for printing current node data. 
   Note that different data types need different specifier in printf() */
void printList(struct Node *node, void (*fptr)(void *)) 
{ 
    while (node != NULL) 
    { 
        (*fptr)(node->data); 
        node = node->next; 
    } 
} 
  
// Function to print an integer 
void printInt(void *n) 
{ 
   printf(" %d", *(int *)n); 
} 
  
// Function to print a float 
void printFloat(void *f) 
{ 
   printf(" %f", *(float *)f); 
}

// part 5.2

int* extendArray(int *array, int currentSize, int newSize) {
    // Use realloc to extend the array
    int *newArray = realloc(array, newSize * sizeof(int));

    // Check if realloc succeeded
    if (newArray == NULL) {
        printf("Memory reallocation failed!\n");
        return NULL;
    }

    // Initialize the new elements to 0
    for (int i = currentSize; i < newSize; i++) {
        newArray[i] = 0;
    }

    return newArray;
}

int main(){
int var = 12;
int *ptr = &var;
printf("value of varriable without pointer %d andvalue with pointer %d\n",var,*ptr);

int a=2, b=3;
int *ptr1=&a, *ptr2 =&b;
swap(ptr1,ptr2);
printf("a and b are now %d ,%d\n ",a,b);

int array[] = {1,2,3,4,5,6,7};
int size = sizeof(array)/sizeof(array[0]);
reverseArray(array,size);
int matrix[3][4];
int matrix1[3][4]={{1,2,3,4},{5,6,7,8},{9,10,11,12}};
printf("Initializing Matrix...\n");
initializeMatrix(3,4,matrix);
printf("Now printing the 2D array:\n");
printMatrix(3,4,matrix1);
printf("Its maximum number is %d\n",findMaxInMatrix(3,4,matrix1));
printf("Now summing its Rows...\n");
sumRows(3,4,matrix1);
int array1[]={7,6,5,4,3,2,1};
int size1 =sizeof(array1)/sizeof(array1[0]);
bubbleSort(array1,size1);
printf("\n");
int array2[]={1,9,3,8,5,0,7};
int size2 =sizeof(array2)/sizeof(array2[0]);

selectionSort(array2,size2);
printf("creating function pointerof selection sort...\n");
void (*funPtr)(int*,int) = bubbleSort;
funPtr(array2,size2);

printf("Part 4.1");

struct Node* head = NULL;

// Insert nodes at the beginning
insertAtBeginning(&head, 3);
insertAtBeginning(&head, 2);
insertAtBeginning(&head, 1);

// Print the initial list
printf("Initial list:\n");
printList(head);

// Delete a node with value 2 and print the list
printf("Deleting node with value 2:\n");
deleteByValue(&head, 2);
printList(head);

// Attempt to delete a node with value 5 (not in the list) and print the list
printf("Deleting node with value 5 (not in the list):\n");
deleteByValue(&head, 5);
printList(head);

printf("part 4.2");

 struct Node *start = NULL;

// Create and print an int linked list
unsigned int_size = sizeof(int);
int arr[] = {10, 20, 30, 40, 50}, i;
for (i=4; i>=0; i--)
      push(&start, &arr[i], int_size);
printf("Created integer linked list is \n");
printList(start, printInt);

// Create and print a float linked list
unsigned float_size = sizeof(float);
start = NULL;
float arr2[] = {10.1, 20.2, 30.3, 40.4, 50.5};
for (i=4; i>=0; i--)
       push(&start, &arr2[i], float_size);
printf("\n\nCreated float linked list is \n");
printList(start, printFloat);

printf("Part 5.1");

int *array;
    int size;
    int sum = 0;
    float average;

    // Asking user for the size of the array
    printf("Enter the size of the array: ");
    scanf("%d", &size);

    // Dynamically allocating memory for the array
    array = (int*)malloc(size * sizeof(int));
    if (array == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }

    // Asking user to input elements of the array
    printf("Enter %d elements:\n", size);
    for (int i = 0; i < size; i++) {
        printf("Element %d: ", i + 1);
        scanf("%d", &array[i]);
    }

    // Calculating the sum of the elements
    for (int i = 0; i < size; i++) {
        sum += array[i];
    }

    // Calculating the average of the elements
    average = (float)sum / size;

    // Printing the sum and average
    printf("Sum of the elements: %d\n", sum);
    printf("Average of the elements: %.2f\n", average);

    // Freeing the allocated memory
    free(array);


printf("Part 5.2");

int *array;
int currentSize, newSize;

// Asking user for the current size of the array
printf("Enter the current size of the array: ");
scanf("%d", &currentSize);

// Dynamically allocating memory for the array
array = (int*)malloc(currentSize * sizeof(int));
if (array == NULL) {
      printf("Memory allocation failed!\n");
       return 1;
}

// Asking user to input elements of the array
printf("Enter %d elements:\n", currentSize);
for (int i = 0; i < currentSize; i++) {
        printf("Element %d: ", i + 1);
        scanf("%d", &array[i]);
}

// Asking user for the new size of the array
printf("Enter the new size of the array: ");
scanf("%d", &newSize);

// Extending the array
array = extendArray(array, currentSize, newSize);
if (array == NULL) {
       free(array);
       return 1;
}

// Displaying the extended array
printf("Extended array elements:\n");
for (int i = 0; i < newSize; i++) {
        printf("Element %d: %d\n", i + 1, array[i]);
}

// Freeing the allocated memory
free(array);

return 0;

}


