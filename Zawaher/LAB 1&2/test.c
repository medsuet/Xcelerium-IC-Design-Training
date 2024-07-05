#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

struct MemoryNode {
    void* address;
    struct MemoryNode* next;
};

struct MemoryNode* head = NULL;

void* allocateMemory(size_t size) {
    void* ptr = malloc(size);
    if (ptr == NULL) {
        printf("Memory allocation failed\n");
        exit(1);
    }

    struct MemoryNode* newNode = (struct MemoryNode*)malloc(sizeof(struct MemoryNode));
    newNode->address = ptr;
    newNode->next = head;
    head = newNode;

    return ptr;
}

void freeMemory(void* ptr) {
    struct MemoryNode* current = head;
    struct MemoryNode* previous = NULL;

    while (current != NULL) {
        if (current->address == ptr) {
            if (previous == NULL) {
                head = current->next;
            } else {
                previous->next = current->next;
            }
            free(current);
            break;
        }
        previous = current;
        current = current->next;
    }

    free(ptr);
}

void inputStudentData(struct Student* s) {
    printf("Enter the name of the student: ");
    getchar(); // Clear the newline left by previous input
    fgets(s->name, sizeof(s->name), stdin);
    s->name[strcspn(s->name, "\n")] = '\0';  // Removes newline character added by fgets.

    printf("Enter student ID: ");
    scanf("%d", &s->id);

    printf("Enter grades for three subjects (separated by space): ");
    scanf("%f %f %f", &s->grades[0], &s->grades[1], &s->grades[2]);
}

float calculateAverage(struct Student* s) {
    float sum = 0.0;
    for (int i = 0; i < 3; i++) {
        sum += s->grades[i];
    }
    return sum / 3.0;
}

void printStudentInfo(struct Student* s) {
    printf("Student Information\n");
    printf("Name: %s\n", s->name);
    printf("Student's ID: %d\n", s->id);
    printf("Student's Grades: %f %f %f\n", s->grades[0], s->grades[1], s->grades[2]);
    printf("Student's Average grade: %f\n", calculateAverage(s));
}

void createUniversity(struct University* uni) {
    printf("Enter the name of university: ");
    getchar(); // Clear the newline left by previous input
    fgets(uni->name, sizeof(uni->name), stdin);
    uni->name[strcspn(uni->name, "\n")] = '\0';  // Removes newline character added by fgets.

    printf("Enter the number of departments: ");
    scanf("%d", &uni->numDepartments);

    // Allocate memory for departments
    uni->departments = (struct Department*)allocateMemory(uni->numDepartments * sizeof(struct Department));
    if (uni->departments == NULL) {
        fprintf(stderr, "Memory allocation failed. Exiting...\n");
        exit(1);
    }

    // Enter details for each department
    for (int i = 0; i < uni->numDepartments; i++) {
        printf("Enter the name of department: ");
        getchar(); // Clear the newline left by previous input
        fgets(uni->departments[i].name, sizeof(uni->departments[i].name), stdin);
        uni->departments[i].name[strcspn(uni->departments[i].name, "\n")] = '\0';  // Removes newline character added by fgets.

        printf("Enter the number of students: ");
        scanf("%d", &uni->departments[i].numStudents);

        // Allocate memory for the students
        uni->departments[i].students = (struct Student*)allocateMemory(uni->departments[i].numStudents * sizeof(struct Student));
        if (uni->departments[i].students == NULL) {
            printf("Memory allocation failed for Students\n");
            exit(1);
        }

        // Enter details for each student in the department
        for (int j = 0; j < uni->departments[i].numStudents; j++) {
            printf("\nEnter details for student #%d in %s department:\n", j + 1, uni->departments[i].name);
            inputStudentData(&uni->departments[i].students[j]);
        }
    }
}

void printUniversityHierarchy(struct University* uni) {
    printf("\nUniversity Name: %s\n", uni->name);
    for (int i = 0; i < uni->numDepartments; i++) {
        printf("Department: %s\n", uni->departments[i].name);
        for (int j = 0; j < uni->departments[i].numStudents; j++) {
            printf("  Student #%d:\n", j + 1);
            printStudentInfo(&uni->departments[i].students[j]);
        }
    }
}

void freeUniversity(struct University* uni) {
    for (int i = 0; i < uni->numDepartments; i++) {
        freeMemory(uni->departments[i].students);
    }
    freeMemory(uni->departments);
}

void checkMemoryLeaks() {
    struct MemoryNode* current = head;
    while (current != NULL) {
        printf("Memory leak detected: %p\n", current->address);
        struct MemoryNode* temp = current;
        current = current->next;
        free(temp);
    }
}

int main() {
    struct University uet;
    createUniversity(&uet);

    printUniversityHierarchy(&uet);

    // Free allocated memory
    freeUniversity(&uet);

    // Check for memory leaks
    checkMemoryLeaks();

    return 0;
}
