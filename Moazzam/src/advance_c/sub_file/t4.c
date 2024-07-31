#include <stdio.h>
#include <stdlib.h>

// Define a structure named 'Node'
struct Node {
    int value;
    struct Node* next;
};

// Function to insert a node at the beginning
void insertAtBeginning(struct Node** head, int value) {
    // Allocate memory for a new node
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    if (newNode == NULL) {
        printf("Memory allocation failed\n");
        return ;
    }

    // Assign value to the new node
    newNode->value = value;
    // Point the new node's next to the current head
    newNode->next = *head;
    // Update the head to the new node
    *head = newNode;
}

void deleteByValue(struct Node** head, int value) {
    struct Node* temp = *head, *prev = NULL;

    // If head node itself holds the value to be deleted
    if (temp != NULL && temp->value == value) {
        *head = temp->next; // Change head
        free(temp); // Free old head
        return;
    }

    // Search for the value to be deleted
    while (temp != NULL && temp->value != value) {
        prev = temp;
        temp = temp->next;
    }

    // If value was not present in the list
    if (temp == NULL) return;

    // Unlink the node from the linked list
    prev->next = temp->next;

    free(temp); // Free memory
}


// Function to print the linked list
void printList(struct Node* head) {
    struct Node* temp = head;
    while (temp != NULL) {
        printf("%d -> ", temp->value);
        temp = temp->next;
    }
    printf("NULL\n");
}

struct GenericNode {
    void *data; // void can store variable of any type
    size_t size;
    struct GenericNode* next;
};

void genericinsertAtBeginning(struct GenericNode** head, void *new_data, size_t data_size) {
    // TODO: Implement insert at beginning
    int i;

    struct GenericNode *newnode;

    newnode = (struct GenericNode *)malloc(sizeof(struct GenericNode));

    newnode->data = malloc(data_size); // creating a memory through datasize since we don't know type of data

    newnode->size = data_size;

    newnode->next = *head; // head becomes the next node

    *head = newnode;

    // since the new data is of void type, we will conver it into char and store it
    // since new_data is a pointer, we will use (char *) for type conversion

    for (i=0; i<data_size; i++)
    {
        * (char *)(newnode->data+i) = *(char *)(new_data+i); // storing character by character
    }
}


void genericprintList(struct GenericNode *head, void (*fptr)(void *))
{
    while (head != NULL)
    {
        (*fptr)(head->data);
        head = head->next;
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

int main() {
    struct Node* start = NULL; // Initialize start as NULL

    // Insert values at the beginning
    
    insertAtBeginning(&start, 1);
    insertAtBeginning(&start, 2);
    insertAtBeginning(&start, 3);

    // Print the linked list
    printf("Linked list after inserting nodes:");
    printList(start);

    deleteByValue(&start, 2);

    printf("Linked list after deleting nodes:");
    printList(start);

    free(start);

        printf("\nTask 4.2: Generic Linked List\n");

    struct GenericNode* new_head = NULL;

    int test_array[] = {10,20,30};

    genericinsertAtBeginning(&new_head,&test_array[0],sizeof(test_array[0]));
    genericinsertAtBeginning(&new_head,&test_array[1],sizeof(test_array[0]));
    genericinsertAtBeginning(&new_head,&test_array[2],sizeof(test_array[0]));


    printf("Integer Linked list after inserting nodes: ");
    genericprintList(new_head,printInt);
    printf("\n");
    free(new_head);

    struct GenericNode* float_head = NULL;

    float test_array2[] = {10.5,20.3,30.1};

    genericinsertAtBeginning(&float_head,&test_array2[0],sizeof(test_array2[0]));
    genericinsertAtBeginning(&float_head,&test_array2[1],sizeof(test_array2[1]));
    genericinsertAtBeginning(&float_head,&test_array2[2],sizeof(test_array2[2]));


    printf("Float Linked list after inserting nodes: ");
    genericprintList(float_head,printFloat);
    printf("\n");
    free(float_head);


    return 0;
}
