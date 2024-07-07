#include <stdio.h>

//----------------------------will get segmentation fualt-------------------------------
//A link list


struct Node{
	int data;
	struct Node *next;
};

void insertAtBeginning(struct Node *head, int value) {
    //------------------Segmentation_fault-------------------
    //argument: starting index(head), value wanna add
    // Add the value in the linklist of it have space.

    struct Node *temp;
   // Assign data to the new node
    temp->data = value;
    temp->next = head->next;
    // Update head to point to the new node
    head = temp;
    // Increment node count
  
}


void printList(struct Node *head) {
    /* arguments: takes head pointer
     * and print the values*/
    while (head != NULL) {
        printf("%d ", head->data);
        head = head->next;
    }
    printf("\n");
}


int main(){
    struct Node *head = NULL;
    insertAtBeginning(head, 5);
    insertAtBeginning(head, 10);
    insertAtBeginning(head, 15);
return 0;
}

