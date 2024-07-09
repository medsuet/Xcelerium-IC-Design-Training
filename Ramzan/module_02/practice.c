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
