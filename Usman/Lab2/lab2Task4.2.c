#include <stdio.h>
#include <stdlib.h>

struct Node1 {
    void* data;
   struct Node1* next;
};
// Function to add a node at the beginning of Linked List. 

void push(struct Node1** head_ref, void *new_data, size_t data_size)
{

    struct Node1* new_node = (struct Node1*)malloc(sizeof(struct Node1));

    new_node->data  = malloc(data_size);
    new_node->next = *head_ref;

    // Copy contents of new_data to newly allocated memory. 

    int i;
    for (i=0; i<data_size; i++)
        *(char *)(new_node->data + i) = *(char *)(new_data + i);


    (*head_ref)    = new_node;
}
/* Function to print nodes in a given linked list. fpitr is used 
   to access the function to be used for printing current node data. 
   Note that different data types need different specifier in printf() */
void printList(struct Node1 *node, void (*fptr)(void *))
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
 
int main(){
printf("part 4.2");
struct Node1 *start = NULL;
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
printf("\n");
return 0;
}
