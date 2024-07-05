#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define the Student structure
struct Student {
    char name[50];
    int id;
    float grades[3];
};

// Define the Department structure
struct Department {
    char name[50];
    struct Student* students;
    int numStudents;
};

// Define the University structure
struct University {
    char name[100];
    struct Department* departments;
    int numDepartments;
};

// Define the Union Data structure
union Data {
    int i;
    float f;
    char c;
};

void setInt(union Data* data, int value){
      data->i = value;
}

void setFloat(union Data* data, float value ){
        data->f = value;
}

void setChar(union Data* data, char calue){
       data->c  =value;
}

void printUnionData(union Data* data, char type) {
    if (type == 'i') {
        printf("Union contains int: %d\n", data->i);
    } else if (type == 'f') {
        printf("Union contains float: %f\n", data->f);
    } else if (type == 'c') {
        printf("Union contains char: %c\n", data->c);
    } else {
        printf("Unknown type\n");
    }
}

// Function to input student data
void inputStudentData(struct Student* student) {
    printf("Enter student name: ");
    scanf(" %[^\n]", student->name);
    printf("Enter student ID: ");
    scanf("%d", &student->id);
    printf("Enter grades (3 subjects): ");
    for (int i = 0; i < 3; i++) {
        scanf("%f", &student->grades[i]);
    }
}

// Function to print student info
void printStudentInfo(struct Student* student) {
    printf("Student Name: %s\n", student->name);
    printf("Student ID: %d\n", student->id);
    printf("Grades: ");
    for (int i = 0; i < 3; i++) {
        printf("%f ", student->grades[i]);
    }
    printf("\n");
}

// Function to calculate average grade
float calculateAverage(struct Student* student) {
    float sum = 0;
    for (int i = 0; i < 3; i++) {
        sum += student->grades[i];
    }
    return sum / 3;
}

int main() {
    struct Student* s1 = (struct Student*)malloc(sizeof(struct Student));

    inputStudentData(s1);
    printStudentInfo(s1);
    printf("Your grade average is: %f\n", calculateAverage(s1));

    struct University* u = (struct University*)malloc(sizeof(struct University));

    printf("Enter university name: ");
    scanf(" %[^\n]", u->name);

    printf("Enter number of departments: ");
    scanf("%d", &(u->numDepartments));

    u->departments = (struct Department*)malloc(u->numDepartments * sizeof(struct Department));

    for (int i = 0; i < u->numDepartments; i++) {
        printf("Enter department name: ");
        scanf(" %[^\n]", u->departments[i].name);

        printf("Enter number of students in department %s: ", u->departments[i].name);
        scanf("%d", &(u->departments[i].numStudents));

        u->departments[i].students = (struct Student*)malloc(u->departments[i].numStudents * sizeof(struct Student));

        for (int j = 0; j < u->departments[i].numStudents; j++) {
            printf("Enter details for student %d in department %s:\n", j + 1, u->departments[i].name);
            inputStudentData(&u->departments[i].students[j]);
        }
    }

    // Print the university information
    printf("\nUniversity Name: %s\n", u->name);
    for (int i = 0; i < u->numDepartments; i++) {
        printf("Department Name: %s\n", u->departments[i].name);
        for (int j = 0; j < u->departments[i].numStudents; j++) {
            printStudentInfo(&u->departments[i].students[j]);
            printf("Grade average: %f\n", calculateAverage(&u->departments[i].students[j]));
        }
    }


    union Data data;
    setInt(&data, 42);
    printUnionData(&data, 'i');

    setFloat(&data, 3.14);
    printUnionData(&data, 'f');

    setChar(&data, 'A');
    printUnionData(&data, 'c');


    // Free allocated memory
    for (int i = 0; i < u->numDepartments; i++) {
        free(u->departments[i].students);
    }
    free(u->departments);
    free(u);
    free(s1);

    return 0;
}

