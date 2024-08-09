#include <stdio.h>
#include <stdlib.h>
typedef struct Node{
    int data;
    struct Node * next;
}Node;

void PrintLinkedList(Node* ptr);
Node* NodeInsertionAtBeginning(Node* head,int Data);
Node* NodeDeletionByValue(Node* head,int value);
int main(){
    int n,value,key;
    Node* head=NULL;
    printf("Enter the the size of the Linked List you want to make: ");
    scanf("%d",&n);
    for(int i=0;i<n;++i){
        printf("\nEnter the %dth value of the Linked List you want to make: ",n-i);
        scanf("%d",&value);
        head=NodeInsertionAtBeginning(head,value);
    }
    printf("\n");
    printf("Linked List Before deletion\n");
    PrintLinkedList(head);
    printf("\nEnter value that you want to remove from the Linked List: ");
    scanf("%d",&key);
    printf("\n");
    head=NodeDeletionByValue(head,key);
    printf("Linked List After deletion\n");
    PrintLinkedList(head);
    // Free allocated memory
    Node* current=head;
    Node* NextNode;
    while (current!=NULL)
    {
        NextNode=current->next;
        free(current);
        current=NextNode;
    }
    return 0;
}
void PrintLinkedList(Node* ptr){
    while (ptr!=NULL)
    {
        printf("%d->",ptr->data);
        ptr=ptr->next;
    }
    printf("NULL");
}
Node* NodeInsertionAtBeginning(Node* head,int Data){
    //Allocating memory for nodes in the heap
    Node * NewNode=(Node*)malloc(sizeof(Node));
    if (NewNode == NULL) {
        printf("Memory allocation failed\n");
        exit(1); // Exit if memory allocation fails
    }
    NewNode->next=head;
    head=NewNode;
    NewNode->data=Data;
    return head;
}
/*
Node* NodeDeletionByValue(Node* ptr, int key) {
    //if first node contains value
    Node* Node1=ptr;
    Node* Node2=NULL;
    if ( Node1!=NULL&&Node1->data==key){
        ptr=ptr->next;
        free(Node1);
        return ptr;
    }
    if (Node1==NULL){
        printf("x");
    }
    while(Node1!=NULL&&Node1->data!=key){
        printf("%d\n",Node1->data);
        Node2=Node1->next;
        printf("x%d\n",Node2->data);
        if(Node2->data==key){
            printf("y%d\n",Node2->data);
            Node1->next=Node2->next;
            free(Node2);
        }
        Node1=Node1->next;
    }
    
    return(ptr);
}*/
Node* NodeDeletionByValue(Node* head, int key) {
    //if first node contains value
    Node* Node1=head;
    Node* Node2=head->next;
    if ( Node1!=NULL&&Node1->data==key){
        head=head->next;
        free(Node1);
        return head;

    }
    while(Node2!=NULL&&Node2->data!=key){
        Node1=Node1->next;
        Node2=Node2->next;
    }
    if (Node2 != NULL && Node2->data==key){
        Node1->next=Node2->next;
        free(Node2);

    }
    else{
            printf("\nTyped Value not in Linked List\n");
    }
    return(head);
}