#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define MAX_ALLOCATIONS 1000

typedef struct {
    void* address;
	size_t size;
} MemoryRecord;

MemoryRecord allocations[MAX_ALLOCATIONS];
int allocationCount = 0;


// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    // TODO: Implement swap function
    int temp = *a;
    *a = *b;
    *b = temp;
}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    int *start = arr;          // Pointer to the start of the array
    int *end = arr + size - 1; // Pointer to the end of the array
    int temp;

    while (start < end) {
        // Swap the elements at start and end
        temp = *start;
        *start = *end;
        *end = temp;

        // Move the pointers towards the middle
        start++;
        end--;
    }
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    srand(time(NULL));  // Seed the random number generator
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 100;  // Random values between 0 and 99
        }
    }
    // TODO: Initialize matrix with random values
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
     for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d\t", matrix[i][j]);
        }
        printf("\n");
    }
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    // let's start by assuming that first element of the matrix is maximum
    // We will itterate through the matrix
    // If there is a number that is greater than our initial assumption we will select that as the maximum number
    int i,j;
    int max = matrix[0][0];
    for (i = 0; i < rows; i++){
        for (j = 0; j < cols; j++){
            if (matrix[i][j] > max) {
                max = matrix[i][j];
            }
        }
    }
    return max;
}

void sumOfRows(int rows, int cols, int (*matrix)[cols]) {
    for (int i = 0; i < rows; i++) {
        int sum = 0;
        for (int j = 0; j < cols; j++) {
            sum += matrix[i][j];
        }
        printf("Sum of row %d: %d\n", i, sum);
    }
}

// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
    for (int i = 0; i < (size - 1); i++) {
        for (int j = 0; j < (size - i - 1); j++) {
            if (arr[j] > arr[j + 1]) {
                // Swap arr[j] and arr[j + 1]
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}


void selectionSort(int *arr, int size) {
    // TODO: Implement selection sort
    for (int i = 0; i < (size - 1); i++) {
        int minIndex = i;
        for (int j = (i + 1); j < size; j++) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        // Swap the found minimum element with the first element
        int temp = arr[minIndex];
        arr[minIndex] = arr[i];
        arr[i] = temp;
    }
}

typedef void (*SortFunction)(int*, int);

// Function pointer type for arithmetic operations
typedef int (*OperationFunc)(int, int);
// Function to perform the calculation
int calculate(OperationFunc op, int a, int b) {
    return op(a, b);
}

// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

// Part 4: Linked List
struct Node {
    int data;
    struct Node* next;
};

// // Define a function pointer to call the funcions to create a generic linked list
// // We can declare this to as atype to a function pointer
// typedef void (*linkedListOperation)(struct Node**, void*);

// // Another function pointer with which we can call printList function
// typedef void (*printListOp)(struct Node*);

void insertAtBeginning(struct Node** head, int value) {
    // TODO: Implement insert at beginning
	
	// Allocate memory for the new node
	struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
	if (!newNode) {
		printf("Memory allocation failed\n");
		return;
	}
	newNode->data = value;
	newNode->next = *head;
	*head = newNode;
}

void deleteByValue(struct Node** head, int value) {
    // TODO: Implement delete by value
	struct Node* current = *head;
	struct Node* prev = NULL;

	// If the head node itself holds the value to be deleted
	if (current != NULL && current->data == value) {
		*head = current->next; // Change head
		free(current); // Free old head
		return;
	}

	// Search for the value to be deleted, keep track of the previous node
	while (current != NULL && current->data != value) {
		prev = current;
		current = current->next;
	}

	// If the value was not present in the list
	if (current == NULL) {
		printf("Value %d not found in the list.\n", value);
		return;
	}

	// Unlink the node from the linked list
	prev->next = current->next;

	free(current); // Free memory
}

void printList(struct Node* head) {
    // TODO: Implement print list
	
	// Printing the data of linked list
	struct Node* pointertoPrint = head;
	while (pointertoPrint != NULL) {
        printf("%d -> ", pointertoPrint->data);
		pointertoPrint = pointertoPrint->next;
	}
	printf("NULL\n");
}

// Part 5: Dynamic Memory Allocation

int* createDynamicArray(int size) {
    int*ptr = (int*)malloc(size*sizeof(int));
	    if (ptr == NULL) {
		    printf("Memory allocation failed\n");
	        exit(1); // Exit the program with an error code
		}
	return ptr;
	// TODO: Allocate memory for an array of integers
}

void extendArray(int** arr, int* size, int newSize) {
    // TODO: Extend the array using realloc()
	// Reallocate the array to the new size
	int* temp = realloc(*arr, newSize * sizeof(int));
    if (temp == NULL) {
        // Handle memory allocation failure
	    printf("Memory allocation failed\n");
	    return;
	}
	*arr = temp;
	*size = newSize;
}

// Memory leak detector
void* allocateMemory(size_t size) {
   
    // TODO: Allocate memory and keep track of it
    if (allocationCount >= MAX_ALLOCATIONS) {
	    printf("Memory allocation limit reached\n");
	    exit(1);
	}
	void* ptr = malloc(size);
	if (ptr == NULL) {
		printf("Memory allocation failed\n");
		exit(1);
    }

    // Record the allocation
	allocations[allocationCount].address = ptr;
	allocations[allocationCount].size = size;
    allocationCount++;

   return ptr;
}

void freeMemory(void* ptr) {
    // TODO: Free memory and update tracking
    if (ptr == NULL) {
	    return;
	}

    for (int i = 0; i < allocationCount; i++) {
	    if (allocations[i].address == ptr) {
		    free(ptr);
		    allocations[i] = allocations[allocationCount - 1];
			allocationCount--;
			return;
		}
	}

	printf("Warning: Attempt to free untracked memory at address %p\n", ptr);
}

void checkMemoryLeaks() {
    // TODO: Check for memory leaks
    if (allocationCount == 0) {
	    printf("No memory leaks detected.\n");
	} else {
		printf("Memory leaks detected:\n");
		for (int i = 0; i < allocationCount; i++) {
		    printf("Leaked memory address: %p, size: %zu bytes\n",
		    allocations[i].address, allocations[i].size);
		}
	}
}

// Part 6: Structures and Unions

struct Student {
    char name[50];
    int id;
    float grades[3];
};

struct Department {
    char name[50];
    struct Student* students;
    int numStudents;
};

struct University {
    char name[100];
    struct Department* departments;
    int numDepartments;
};

union Data {
    int i;
    float f;
    char c;
};


void inputStudentData(struct Student* s) {
    // TODO: Implement this function
	// Input student name
	printf("Enter student name: ");
   
    // Read unit newline
	scanf(" %s", s->name); 
			    
    // Input student ID
	printf("Enter student ID: ");
	scanf("%d", &s->id);
							    
	// Input student grade
	for (int i = 0; i < 3; i++) {
		printf("Enter grade %d: ", i + 1);
		scanf("%f", &s->grades[i]);
    }
}

// Function to calculate the average of grades of a student
float calculateAverage(struct Student* s) {
    // TODO: Implement this function
    
	float sum = 0.0;
	for (int i = 0; i < 3; i++) {
	    sum += s->grades[i];
	}
	return sum / 3;
}

// Function to print student information
void printStudentInfo(struct Student* s) {
    // TODO: Implement this function
	printf("Student Name: %s\n", s->name);
	printf("Student ID: %d\n", s->id);
    printf("Grades: ");
	for (int i = 0; i < 3; i++) {
		printf("%.2f ", s->grades[i]);
	}
	printf("\n");
	printf("Average Grade: %.2f\n", calculateAverage(s));
}

// Part 7: File I/O

void writeStudentToFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a text file
	FILE* file = fopen(filename, "w");
	if(file == NULL) {
	    printf("Error opening file for writing");
	}
	fprintf(file, "Name:%s\n", s->name);
	fprintf(file, "Id:%d\n", s->id);
	fprintf(file, "Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);

	fclose(file);
}

void readStudentFromFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a text file
	FILE* file = fopen(filename, "r");
	if(file == NULL) {
		printf("Error opening file for reading");
	}
	char myString[100];
	while(fgets(myString,100,file)) {
		printf("%s", myString);
	};
	fclose(file);
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a binary file
	// Open the file in binary write mode
	FILE* file = fopen(filename, "wb");
	if (file == NULL) {
		perror("Error opening file");
		return;
	}

	// Write the student structure to the file
	size_t written = fwrite(s, sizeof(struct Student), 1, file);
	if (written != 1) {
		perror("Error writing to file");
	}

	// Close the file
	fclose(file);
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file
	
	// Open the file in binary read mode
	FILE* file = fopen(filename, "rb");
	if (file == NULL) {
		perror("Error opening file");
		return;
	}

	// Read the student structure from the file
	while (fread(s, sizeof(struct Student), 1, file) == 1) {
		
		// Print the read data to the terminal
		printf("Name: %s\n", s->name);
		printf("ID: %d\n", s->id);
		printf("Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);
	}

	// Close the file
	fclose(file);
}

// Function to get the current timestamp as a string
void getCurrentTimestamp(char* buffer, size_t bufferSize) {
    time_t now = time(NULL);
	struct tm* tstruct = localtime(&now);
	strftime(buffer, bufferSize, "%Y-%m-%d %H:%M:%S", tstruct);
}

void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
	FILE* file = fopen(logfile, "a");
	if (file == NULL) {
	    perror("Error opening log file");
	    return;
	}
	// Generating current timestamp
	char timestamp[20];
    getCurrentTimestamp(timestamp, sizeof(timestamp));
	    
	
	// log message with timestamp
	fprintf(file, "%s - %s\n", timestamp, message);
	
	fclose(file);
}

void displayLog(const char* logfile) {
    // TODO: Read and display the contents of the log file
	FILE* file = fopen(logfile, "r");
	if (file == NULL) {
        perror("Error opening log file");
		return;
	}

	char line[256];
	while (fgets(line, sizeof(line), file)) {
	    printf("%s", line);
	}
	
	// closing the file
	fclose(file);

}


int main() {
    srand(time(NULL));

    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n");
    // TODO: Implement exercises 1.1, 1.2, and 1.3
    
	// Part 1.1
    // Declare an integer variable and initialize it
	int num = 10;       
    
	// Declare a pointer to the integer variable
    int *ptr = &num;   

    // Print the value of the variable using direct access
    printf("Value of num (direct access): %d\n", num);

    // Print the value of the variable using the pointer
    printf("Value of num (using pointer): %d\n", *ptr);

    // Modify the value using the pointer
    *ptr = 20;

    // Print the new value of the variable using direct access
    printf("New value of num (direct access): %d\n", num);

    // Print the new value of the variable using the pointer
    printf("New value of num (using pointer): %d\n", *ptr);

    //Part 1.2
    int num1 = 5;
    int num2 = 10;

    // Print the original values
    printf("Before swap: num1 = %d, num2 = %d\n", num1, num2);

    // Call the swap function
    swap(&num1, &num2);

    // Print the swapped values
    printf("After swap: num1 = %d, num2 = %d\n", num1, num2);
     
    //Part 1.3
    int i;
    int sum=0;
    int arr[] = {1, 2, 3, 4};
    int length = sizeof(arr) / sizeof(arr[0]);

    // Printing elements of the array
    printf("Elements pf array: ");
    for (i = 0; i < length; i++){
        printf("%d ",arr[i]);
    }
    // Calculating sum of the elements of array
    printf("\nSum of the elements of array: ");
    for (i = 0; i < length; i++){
        sum = sum + arr[i];
    }
    // Displaying the sum of array
    printf("%d\n",sum);

    // Reversing the array
    reverseArray(arr, length);
    
	// Print the reversed array
    printf("Reversed array: ");
    for (int i = 0; i < length; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    ////////////// Part 1 Complete /////////////

    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    // TODO: Implement exercises 2.1 and 2.2
    
	// Part 2.1
    int rows = 3;
    int cols = 4;
    int matrix[rows][cols];
    int max;
    // Initialize the matrix with random values
    initializeMatrix(rows, cols, matrix);

    // Print the matrix
    printf("Matrix:\n");
    printMatrix(rows, cols, matrix);
    
    // Maximum element of the array
    max = findMaxInMatrix(rows, cols, matrix);
    printf("Maximum element in the matrix is: %d\n", max);

    // Part 2.2
    
	// Calculate and print the sum of each row
    sumOfRows(rows, cols, matrix);
    /////////////// Part 2 Complete //////////////

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3
    
	// Part 3.1
    int arr1[] = {64, 25, 12, 22, 11};  // Example array
    int size = sizeof(arr1) / sizeof(arr1[0]);

    // Print original array
    printf("Original array:\n");
    
	// Printing elements of the array
    for (i = 0; i < size; i++){
        printf("%d ",arr1[i]);
    }
    // Sort the array using Bubble Sort
    bubbleSort(arr1, size);
    printf("\nArray after Bubble Sort:\n");
    for (i = 0; i < size; i++){
        printf("%d ",arr1[i]);
    }
    // Re-initialize the array for Selection Sort
    int arr2[] = {64, 25, 12, 22, 11};
    size = sizeof(arr2) / sizeof(arr2[0]);

    // Print the array before Selection Sort
    printf("\nOriginal array for Selection Sort:\n");
    for (i = 0; i < size; i++){
        printf("%d ",arr2[i]);
    }
    // Sort the array using Selection Sort
    selectionSort(arr2, size);
    printf("\nArray after Selection Sort:\n");
    for (i = 0; i < size; i++){
        printf("%d ",arr2[i]);
    }

    // Part 3.2
    SortFunction sortFunc = bubbleSort;
    int arr3[] = {64, 25, 12, 22, 11};  // Example array
    size = sizeof(arr3) / sizeof(arr3[0]);

    // Print original array
    printf("\nOriginal array:\n");
    
	// Printing elements of the array
    for (i = 0; i < size; i++){
        printf("%d ",arr3[i]);
    }
    
	// Sort the array using Bubble Sort
    sortFunc(arr3, size);
    printf("\nArray after Bubble Sort using Function pointer:\n");
    for (i = 0; i < size; i++){
        printf("%d ",arr3[i]);
    }

    // Part 3.3
    int number1, number2;
    char op;

    // User input
    printf("\nEnter first number: ");
    scanf("%d", &number1);
    printf("Enter an operator (+, -, *, /): ");
    
	// Note the space before %c to consume any leftover whitespace
    scanf(" %c", &op);  
    printf("Enter second number: ");
    scanf("%d", &number2);

    // Function pointer for the chosen operation
    OperationFunc func;

    // Determine which operation to use
    switch (op) {
        case '+':
            func = add;
            break;
        case '-':
            func = subtract;
            break;
        case '*':
            func = multiply;
            break;
        case '/':
            func = divide;
            break;
        default:
            printf("Error: Invalid operator.\n");
            return 1;
    }

    // Perform the calculation
    int result = calculate(func, number1, number2);

    // Output the result
    printf("Result: %d\n", result);
    //////////////// Part 3 Complete ///////////////
    
    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2
	
	// Part 4.1
	
	// Creating a simple linked list
	// Creating the first node
	// head is a pointer to first node
	struct Node *head = (struct Node*)malloc(sizeof(struct Node));
	if (!head) {
	    printf("Memory allocation failed\n");
		return 1;
	}

	head->data = 45;
	head->next = NULL;

	// Creating the second node
	struct Node* current = (struct Node*)malloc(sizeof(struct Node));
	if (!head) {
	    printf("Memory allocation failed\n");
		return 1;
	}

	current->data = 99;
	current->next = NULL;
	head->next = current;

	// Creating the third node
	//current = (struct Node*)malloc(sizeof(struct Node));
	//current->data = 5;
	//current->next = NULL;
	//head->next->next = current;
	
	// Print the Linked list before inserting a node at beginning
	printf("Initial list: \n");
	printList(head);

	// Inserting values into the list
	insertAtBeginning(&head, 5);
	insertAtBeginning(&head, 99);

	// Printing the list after inserting a new node at the beginning
	printf("List after inserting new nodes at the beginning:\n");
	printList(head);

	// Deleting a node by value
	deleteByValue(&head, 99);

	// Printing the updated list
	printf("List after deleting 99:\n");
	printList(head);

	// Trying to delete a non-existent value
	deleteByValue(&head, 200);




    
	// Part 5: Dynamic Memory Allocation
    printf("Part 5: Dynamic Memory Allocation\n");
    // TODO: Implement exercises 5.1, 5.2, and 5.3
	// Part 5.1
    
	int oldSize;
	int *dynamicArray;
	int sumofElements;
	float average;

	// Ask the user for the size of the array
	printf("Enter the size of the array: ");
	scanf("%d", &oldSize);
	
	// Create the dynamic array / allocate memory for array
	dynamicArray = createDynamicArray(oldSize);
	
	// Input the elements of the array
	printf("Enter the elements of the array:\n");
	for (int i = 0; i < oldSize; i++) {
	    scanf("%d", &dynamicArray[i]);
	}
    
	// Calculate the sum of the elements of array
    sumofElements = 0;
    for (int i = 0; i < oldSize; i++) {
	    sumofElements += dynamicArray[i];
    }
    
	// Calculate the average of the elements of array
    average = (float)sumofElements / oldSize;
	
	// Print the sum and average of the elements
	printf("Sum: %d\n", sumofElements);
	printf("Average: %.2f\n", average);

   
	// Part 5.2

    // Extend the array to a new size
	int newSize;
	printf("Enter the new size of the array: ");
	scanf("%d", &newSize);
    extendArray(&dynamicArray, &oldSize, newSize);
    
	// Input the elements of extended array	
	printf("Enter the remaining elements of the extended array:\n");
	for (int i = oldSize; i < newSize; i++) {
	    scanf("%d", &dynamicArray[i]);
	}
    
    
	// Part 5.3

	int* array1 = (int*)allocateMemory(10 * sizeof(int));
	int* array2 = (int*)allocateMemory(20 * sizeof(int));

    // Free the dynamically allocated memory
	free(dynamicArray);
    
	freeMemory(array1);
    freeMemory(array2);
	/////////////// Part 5 Complete ///////////////

	// Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4
	
	// Part 6.1, 6.2
	struct Student student;
	inputStudentData(&student);
	printStudentInfo(&student);

	//inputStudentData(&student);
	//printStudentInfo(&student);

	//inputStudentData(&student);
	//printStudentInfo(&student);
	
	// Part 6.3
	struct Department department = {"Electrical Engineering", NULL, 0};
    struct University university = {"UET,Lahore", &department, 1};
    department.students = (struct Student*)malloc(1 * sizeof(struct Student));
    department.numStudents = 1;
    department.students[0] = student;
	
	// printing the name of university, its department and students
    printf("\nUniversity: %s\n", university.name);
    printf("Department: %s\n", department.name);
    printf("Number of Students in Department: %d\n", department.numStudents);
    for (int i = 0; i < department.numStudents; i++) {
        printStudentInfo(&department.students[i]);
    }

    // Free allocated memory
    free(department.students);
	// Part 6.4
	
	// Declare a union variable
	printf("Use of unions\n");
	union Data data;

    // Store and display an integer
	data.i = 42;
	printf("Data as int: %d\n", data.i);

	// Store and display a float
	data.f = 3.14;
	printf("Data as float: %.2f\n", data.f);

	// Store and display a char
	data.c = 'A';
	printf("Data as char: %c\n", data.c);

	// Demonstrate that only the last stored value is valid
	printf("Data as int after storing char: %d\n", data.i);
	printf("Data as float after storing char: %.2f\n", data.f);

	////////////// Part 6 Complete /////////////////

    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3
	
	// Part 7.1
	const char* filename = "student.txt";
	writeStudentToFile(&student, filename);
	readStudentFromFile(&student, filename);	
    
	// Part 7.2
	// Call the function to write the student data to a binary file
	writeStudentToBinaryFile(&student, "student.dat");
	readStudentFromBinaryFile(&student, "student.dat");

	// Part 7.3
	const char* logfile = "app.log";

	// Log some messages
	logMessage("Application started", logfile);
	logMessage("Performing some operations", logfile);
	logMessage("Application finished", logfile);

	// Read and display the log file
	printf("Log file contents:\n");
	displayLog(logfile);


	checkMemoryLeaks();

    return 0;
}
