#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 4: Linked List
struct Node {
    int data;
    struct Node* next;
};


void insertAtBeginning(struct Node** head, int value) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    if (newNode == NULL){
        printf("Memory allocation Failed\n");
        return;
    } 
    
    // Set the data for the new node
    newNode->data = value;
    // Point the next of new node to the current head
    newNode->next = *head;
    // Move the head to point to the new node
    *head = newNode;

}

void deleteByValue(struct Node** head, int value) {
    struct Node* current = *head;
    struct Node* previous = NULL;
    while ( current != NULL && current->data != value ){
        previous = current;
        current = current->next;           
    }

    if ( current == NULL){
         printf("Value %d not found in the list.\n", value);
        return;
    }
    
    if (previous == NULL) {
        *head = current->next; // The head node is to be deleted
    } 
    
    else {
        previous->next = current->next; // Bypass the current node
    }

    free(current);
    
}




void printList(struct Node* head) {
    struct Node* current = head;
    while (current != NULL) {
        printf("%d -> ", current->data);
        current = current->next;
    }
    printf("NULL\n");
}





int main(void) {

    struct Node* head = NULL;

    insertAtBeginning(&head,10);
    insertAtBeginning(&head,20);
    insertAtBeginning(&head,30);
    insertAtBeginning(&head,40);

    printList(head);     

    deleteByValue(&head, 20);

    printf("List after deleting 20:\n");
    printList(head);


    return 0;
}