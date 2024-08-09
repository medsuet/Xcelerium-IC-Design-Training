#include <stdio.h>
#include <stdlib.h>
typedef union{
    char string[50];
    int intVal;
    double doubleVal;
}DataValue;

typedef struct Node{
    DataValue data;
    struct Node * next;
}Node;

void PrintLinkedList(Node* ptr,int*array);
Node* NodeInsertionAtBeginning(Node* head,DataValue Data);

int main(){
    int n;
    DataValue value;
    Node* head=NULL;
    Node* (*NodeInsertionAtBeginning_ptr)(Node*,DataValue)=&NodeInsertionAtBeginning;
    printf("Enter the the size of the Linked List you want to make: ");
    scanf("%d",&n);
    int *array=(int *)calloc(n,sizeof(int));
    int DataType=0;
    for(int i=0;i<n;++i){
        printf("\nEnter the data type of %dth element of the Linked List you want to make(1 for char,2 for int and 3 for double): ",n-i);
        scanf("%d",&DataType);
        if (DataType==1){
            printf("\nEnter the %dth element of the Linked List you want to make: ",n-i);
            scanf("%s",value.string);
            head=NodeInsertionAtBeginning_ptr(head,value);
            array[n-i-1]=1;
        }
        else if (DataType==2){
            printf("\nEnter the %dth element of the Linked List you want to make: ",n-i);
            scanf("%d",&value.intVal);
            head=NodeInsertionAtBeginning_ptr(head,value);
            array[n-i-1]=2;
        }
        else if (DataType==3){
            printf("\nEnter the %dth element of the Linked List you want to make: ",n-i);
            scanf("%lf",&value.doubleVal);
            head=NodeInsertionAtBeginning_ptr(head,value);
            array[n-i-1]=3;
        }
    }
    printf("\n");
    printf("Linked List Before deletion\n");
    PrintLinkedList(head,array);
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
void PrintLinkedList(Node* ptr,int *array){
    int i=0;
    while (ptr!=NULL)
    {
        if (array[i]==1){
            printf("%s->",ptr->data.string);
            ptr=ptr->next;
        }
        else if (array[i]==2){
            printf("%d->",ptr->data.intVal);
            ptr=ptr->next;
        }
        else if (array[i]==3){
            printf("%lf->",ptr->data.doubleVal);
            ptr=ptr->next;
        }
        i++;
    }
    printf("NULL");
}
Node* NodeInsertionAtBeginning(Node* head,DataValue Data){
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
