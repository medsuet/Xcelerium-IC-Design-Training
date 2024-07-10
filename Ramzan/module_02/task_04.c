//Part 4: Advanced Challenge
//Task 4.1

/*

#include <stdio.h>
#include <stdlib.h>

struct Node {
    int data;
    struct Node* next;
};

void insertAtBeginning(struct Node** head, int value) {
    // Create a new node
    struct Node* newNode = (struct Node*) malloc(sizeof(struct Node));
    if (newNode == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return;
    }
    newNode->data = value;
    newNode->next = *head; // Point new node to current head

    *head = newNode; // Set new node as the head
}

void deleteByValue(struct Node** head, int value) {
    struct Node* temp = *head;
    struct Node* prev = NULL;

    // If head node itself holds the value to be deleted
    if (temp != NULL && temp->data == value) {
        *head = temp->next; // Change head
        free(temp); // Free old head memory
        return;
    }

    // Search for the value to be deleted, keep track of the previous node
    while (temp != NULL && temp->data != value) {
        prev = temp;
        temp = temp->next;
    }

    // If value was not present in the linked list
    if (temp == NULL) return;

    // Unlink the node from the linked list
    prev->next = temp->next;
    free(temp); // Free the memory
}

void printList(struct Node* head) {
    struct Node* temp = head;
    while (temp != NULL) {
        printf("%d ", temp->data);
        temp = temp->next;
    }
    printf("\n");
}

// Example usage
int main() {
    struct Node* head = NULL;

    // Insert nodes
    insertAtBeginning(&head, 3);
    insertAtBeginning(&head, 5);
    insertAtBeginning(&head, 7);

    printf("Initial list: ");
    printList(head);

    // Delete node by value
    deleteByValue(&head, 5);
    printf("List after deletion of 5: ");
    printList(head);

    // Delete non-existing value
    deleteByValue(&head, 10);
    printf("List after deletion of 10 (not present): ");
    printList(head);

    return 0;
}
*/



//Task 4.2



#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define a node structure
typedef struct Node {
    void *data;
    struct Node *next;
} Node;

// Define function pointers for operations on the data
typedef void (*PrintFunc)(void *data);
typedef void (*FreeFunc)(void *data);

// Define a linked list structure
typedef struct LinkedList {
    Node *head;
    PrintFunc printFunc;
    FreeFunc freeFunc;
} LinkedList;

// Function to create a new node
Node* createNode(void *data, size_t dataSize) {
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->data = malloc(dataSize);
    memcpy(newNode->data, data, dataSize);
    newNode->next = NULL;
    return newNode;
}

// Function to initialize a linked list
void initList(LinkedList *list, PrintFunc printFunc, FreeFunc freeFunc) {
    list->head = NULL;
    list->printFunc = printFunc;
    list->freeFunc = freeFunc;
}

// Function to insert a node at the beginning
void insertNode(LinkedList *list, void *data, size_t dataSize) {
    Node *newNode = createNode(data, dataSize);
    newNode->next = list->head;
    list->head = newNode;
}

// Function to print the list
void printList(LinkedList *list) {
    Node *current = list->head;
    while (current != NULL) {
        list->printFunc(current->data);
        current = current->next;
    }
    printf("\n");
}

// Function to delete the list and free memory
void deleteList(LinkedList *list) {
    Node *current = list->head;
    Node *next;
    while (current != NULL) {
        next = current->next;
        list->freeFunc(current->data);
        free(current);
        current = next;
    }
    list->head = NULL;
}

// Function to print an integer
void printInt(void *data) {
    printf("%d ", *(int *)data);
}

// Function to free an integer
void freeInt(void *data) {
    // No additional freeing required for simple data types like int
}

// Function to print a float
void printFloat(void *data) {
    printf("%f ", *(float *)data);
}

// Function to free a float
void freeFloat(void *data) {
    // No additional freeing required for simple data types like float
}

// Function to print a string
void printString(void *data) {
    printf("%s ", (char *)data);
}

// Function to free a string
void freeString(void *data) {
    free(data);
}

int main() {
    LinkedList intList;
    initList(&intList, printInt, freeInt);

    int a = 1, b = 2, c = 3;
    insertNode(&intList, &a, sizeof(int));
    insertNode(&intList, &b, sizeof(int));
    insertNode(&intList, &c, sizeof(int));
    printList(&intList);
    deleteList(&intList);

    LinkedList floatList;
    initList(&floatList, printFloat, freeFloat);

    float x = 1.1, y = 2.2, z = 3.3;
    insertNode(&floatList, &x, sizeof(float));
    insertNode(&floatList, &y, sizeof(float));
    insertNode(&floatList, &z, sizeof(float));
    printList(&floatList);
    deleteList(&floatList);

    LinkedList stringList;
    initList(&stringList, printString, freeString);

    char *str1 = strdup("Hello");
    char *str2 = strdup("World");
    insertNode(&stringList, str1, strlen(str1) + 1);
    insertNode(&stringList, str2, strlen(str2) + 1);
    printList(&stringList);
    deleteList(&stringList);

    return 0;
}
