#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define an enum for the type of data
enum DataType { INT, FLOAT, STRING };

// Define a union to hold different types of data
union Data {
    int i;
    float f;
    char str[20];
};

// Define a struct for the linked list node
struct Node {
    enum DataType type;
    union Data data;
    struct Node* next;
};

// Function to create a new node with integer data
struct Node* createIntNode(int value) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->type = INT;
    newNode->data.i = value;
    newNode->next = NULL;
    return newNode;
}

// Function to create a new node with float data
struct Node* createFloatNode(float value) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->type = FLOAT;
    newNode->data.f = value;
    newNode->next = NULL;
    return newNode;
}

// Function to create a new node with string data
struct Node* createStringNode(const char* value) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->type = STRING;
    strcpy(newNode->data.str, value);
    newNode->next = NULL;
    return newNode;
}

// Function to print a node's data
void printNode(struct Node* node) {
    if (node->type == INT) {
        printf("INT: %d\n", node->data.i);
    } else if (node->type == FLOAT) {
        printf("FLOAT: %.2f\n", node->data.f);
    } else if (node->type == STRING) {
        printf("STRING: %s\n", node->data.str);
    }
}

// Function to print the entire linked list
void printList(struct Node* head) {
    struct Node* current = head;
    while (current != NULL) {
        printNode(current);
        current = current->next;
    }
}

// Function to free the entire linked list
void freeList(struct Node* head) {
    struct Node* current = head;
    struct Node* next;
    while (current != NULL) {
        next = current->next;
        free(current);
        current = next;
    }
}

int main() {
    // Create linked list nodes
    struct Node* head = createIntNode(10);
    head->next = createFloatNode(20.5);
    head->next->next = createStringNode("Hello, World!");

    // Print the linked list
    printList(head);

    // Free the linked list
    freeList(head);

    return 0;
}
