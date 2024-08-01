#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

struct Node{
    int data;
    struct Node* next;
};

union Data
{
    int   i;
    float f;
    char  c;
};


void insertAtBeginning(struct Node** head, int value){
    
    /* Insert a Node at the begining in the linked list */
    struct Node *newnode = NULL;    // new node which i have to insert at beginning

    // allocating the space of new node
    newnode = (struct Node *) malloc( sizeof (struct Node) );

    newnode->next = *head;          // add the address of 1st node into the newnode
    *head = newnode;                // update the head from the address of new node
    newnode->data = value;          // write the data of the new node
}

void deleteByValue(struct Node** head, int value) {

    /* Deleting a node by giving its value */
    struct Node *temp = NULL;       // store for the previous node
    struct Node *nextNode = NULL;    // checking node data
    
    temp = (struct Node *) malloc(sizeof (struct Node));
    nextNode = (struct Node *) malloc(sizeof (struct Node));

    temp = *head;
    nextNode = *head;

    // this loop is use to check the data which user want to remove and 
    // save the previous node into a temp node

    // the node is not head
    while (nextNode->data != value)
    {
        temp = nextNode;
        nextNode = nextNode->next;
    }

    // this condition is for checking that the node is head or not
    if (nextNode == *head) {
        nextNode = nextNode->next;
        *head = nextNode;
    }
    else {
        temp->next = nextNode->next;    // changing the next address of the temp node
    }

    /* if i add this the segmentation fault will print on the terminal 
        (run time error)*/
    //free(nextNode);
}

void printList(struct Node* head) {

    struct Node *temp = NULL;

    // make a temporary node which is use for printing the linked list
    temp = (struct Node *) malloc(sizeof(struct Node));

    // printing the linked list
    temp = head;
    printf("\nYour linked list is :\n   [ ");
    while(temp != NULL)
    {
        printf("%d ", temp->data);
        temp = temp->next;
    }
    printf("]\n");
    free(temp);

}

int main ()
{
    // initial every pointer with NULL a good practice

    struct Node *head = NULL;       // contain the starting address of the linked list
    struct Node *newNode = NULL;    // newNode pointer 
    struct Node *temp = NULL;       // temporary node use to moving and print the list
    int choice = 1;                 // choice which is ask from the user. start is 
                                    // always one because it creates linked list.
    int insertNodeChoice = 0;       // ask from the user to insert a node at beginning
    int delNodeChoice = 0;          // ask from the user to del a node by value
    int beginNodedata;              // first node data
    int delNodedata;                // delete node value

    while(choice)
    {
        // making space in the memory for a new node using malloc function
        newNode = (struct Node *) malloc(sizeof(struct Node));

        // user enter the data of the newNode
        printf("\nEnter data: ");
        scanf("%d", &newNode->data);

        // if head is equal to NULL then give it the starting address of linked list
        if (head == NULL)
        {
            // first node is our newNode
            head = newNode;
            temp = newNode;
        }
        else 
        {
            temp->next = newNode;   // add the next address in temporary node
            temp = newNode;         // temporary node becomes our new node
        }

        // ask from the user if he/she wants to contiune 
        printf("\nDo you want to continue (0,1) ?\nContinue => 1\nNOT Continue => 0\n");
        scanf("%d", &choice);

    } // While loop end for linked list

    // asking from the user to insert a new node at beginning or not
    printf("\nYou want to insert a node (yes[1] or no[0])? ");
    scanf("%d", &insertNodeChoice);

    if(insertNodeChoice == 1){
        printf("\n==== User is inserting a node at the beginning ====\n");
        printf("\nEnter the beginning data: ");
        scanf("%d", &beginNodedata);
        insertAtBeginning(&head, beginNodedata);
    }
    else{
        printf(" === User is not inserting a node === \n");
    }

    printList(head);

    // asking from the user to delete a node by value or not
    printf("\nYou want to del a value (yes[1] or no[0])? ");
    scanf("%d", &delNodeChoice);

    if (delNodeChoice == 1){
        printf("\n==== User is deleting a node by the value ====\n");
        printf("\nEnter the value: ");
        scanf("%d", &delNodedata);
        deleteByValue(&head, delNodedata);
    }
    else{
        printf(" === User is not deleting a node === \n");
    }
    
    printList(head);

    free(head);
    //free(temp);
    free(newNode);

    //printList(head);
    printList(newNode);
    //printList(temp);

    return 0;
}