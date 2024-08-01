#include <stdio.h>
#include <stdlib.h>

// Node structure definition
struct Node {
    void* data;
    struct Node* next;
};

// Function pointer types for data-specific operations
typedef void (*PrintFunc)(void*);
typedef int (*CompareFunc)(void*, void*);
typedef void (*FreeFunc)(void*);

// Linked list structure definition
struct LinkedList {
    struct Node* head;
    PrintFunc printFunc;
    CompareFunc compareFunc;
    FreeFunc freeFunc;
};

// Function to create a new node
struct Node* createNode(void* data) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = data;
    newNode->next = NULL;
    return newNode;
}

// Function to insert a node at the beginning
void insertAtBeginning(struct LinkedList* list, void* data) {
    struct Node* newNode = createNode(data);
    newNode->next = list->head;
    list->head = newNode;
}

// Function to insert a node at the end
void insertAtEnd(struct LinkedList* list, void* data) {
    struct Node* newNode = createNode(data);
    if (list->head == NULL) {
        list->head = newNode;
        return;
    }
    struct Node* temp = list->head;
    while (temp->next != NULL) {
        temp = temp->next;
    }
    temp->next = newNode;
}

// Function to delete a node by comparing data
void deleteNode(struct LinkedList* list, void* key) {
    struct Node* temp = list->head;
    struct Node* prev = NULL;
    while (temp != NULL && list->compareFunc(temp->data, key) != 0) {
        prev = temp;
        temp = temp->next;
    }
    if (temp == NULL) return;
    if (prev == NULL) {
        list->head = temp->next;
    } else {
        prev->next = temp->next;
    }
    list->freeFunc(temp->data);
    free(temp);
}

// Function to print the linked list
void printList(struct LinkedList* list) {
    struct Node* temp = list->head;
    while (temp != NULL) {
        list->printFunc(temp->data);
        temp = temp->next;
    }
    printf("NULL\n");
}

// Utility functions for integer data type
void printInt(void* data) {
    printf("%d -> ", *(int*)data);
}

int compareInt(void* a, void* b) {
    return (*(int*)a - *(int*)b);
}

void freeInt(void* data) {
    free(data);
}

// Main function to demonstrate the generic linked list
int main() {
    struct LinkedList list;
    list.head = NULL;
    list.printFunc = printInt;
    list.compareFunc = compareInt;
    list.freeFunc = freeInt;

    int* num1 = malloc(sizeof(int));
    *num1 = 1;
    insertAtBeginning(&list, num1);

    int* num2 = malloc(sizeof(int));
    *num2 = 2;
    insertAtEnd(&list, num2);

    int* num3 = malloc(sizeof(int));
    *num3 = 3;
    insertAtEnd(&list, num3);

    printf("Linked list: ");
    printList(&list);

    int key = 2;
    deleteNode(&list, &key);
    printf("Linked list after deletion: ");
    printList(&list);

    return 0;
}
