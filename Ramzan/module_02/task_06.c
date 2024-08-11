
//Part 6: Structures and Unions
//Task 6.1&6.2


/*
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

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

int main() {
    struct Student student1 = {"Sara Ali", 1, {3.2, 2.2, 4.5}};
    struct Student student2 = {"Fiqa Ali", 5, {6.2, 4.2, 0.5}};

    // Create a department and allocate memory for students
    struct Department my_dep;
    strcpy(my_dep.name, "Electrical Engineering");
    my_dep.students = (struct Student*)malloc(2 * sizeof(struct Student));
    my_dep.numStudents = 2;

    // Add students to the department
    my_dep.students[0] = student1;
    my_dep.students[1] = student2;

    // Create a university and allocate memory for departments
    struct University my_uni;
    strcpy(my_uni.name, "UET LAHORE");
    my_uni.departments = (struct Department*)malloc(2 * sizeof(struct Department));
    my_uni.numDepartments = 1;

    // Add the department to the university
    my_uni.departments[0] = my_dep;

    // Print information
    printf("University Name: %s\n", my_uni.name);
    printf("Number of Departments: %d\n", my_uni.numDepartments);
    printf("Department Name: %s\n", my_dep.name);
    printf("Number of Students in %s: %d\n", my_dep.name, my_dep.numStudents);

    //now i want to print etc of all above

    for(int i=0;i<my_dep.numStudents;i++)
    {
        printf("Student %d:\n",i+1);
        printf("Name: %s\n",my_dep.students[i].name);
        printf("ID: %d\n",my_dep.students[i].id);
        printf("Grades: %.2f, %.2f, %.2f",my_dep.students[i].grades[0],my_dep.students[i].grades[1],my_dep.students[i].grades[2]);

    }
    printf("\n");
}
*/

//Task 6.2


/*
#include<stdio.h>
struct Student {
    char name[50];
    int id;
    float grades[3];
};

void inputStudentData(struct Student* s);
float calculateAverage(struct Student* s);
void printStudentInfo(struct Student* s);

int main()
{
    struct Student my_students;
    inputStudentData(&my_students);
    printStudentInfo(&my_students);
    calculateAverage(&my_students);
    return 0;
}

void inputStudentData(struct Student* s)
{
    printf("Enter student Name: ");
    scanf("%s",s->name);
    printf("Enter student ID: ");
    scanf("%d",&s->id);

    printf("Enter grades for three subjects: ");
    for(int i=0;i<3;i++)
    {
        scanf("%f",&s->grades[i]);
    }
}

// Function to calculate the average grade
float calculateAverage(struct Student* s) {
    int sum =0;
    for(int j=0;j<3;j++)
    {
        sum = sum+s->grades[j];
    }
    float average = (float)sum/3;
    printf("Average grade: %.2f",average);
}

void printStudentInfo(struct Student* s)
{
    printf("Name: %s\n", s->name);
    printf("ID: %d\n", s->id);
    printf("Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);
}
*/




//Task 6.3



/*

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Structure definitions
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

// Function prototypes
float calculateAverage(struct Student* s);
void printStudentInfo(struct Student* s);
void printDepartmentInfo(struct Department* d);
void printUniversityInfo(struct University* u);

int main() {
    // Create students
    struct Student student1 = {"Sara Ali", 1, {3.2, 2.2, 4.5}};
    struct Student student2 = {"Fiqa Ali", 5, {6.2, 4.2, 0.5}};

    // Create a department and allocate memory for students
    struct Department my_dep;
    strcpy(my_dep.name, "Electrical Engineering");
    my_dep.students = (struct Student*)malloc(2 * sizeof(struct Student));
    my_dep.numStudents = 2;

    // Add students to the department
    my_dep.students[0] = student1;
    my_dep.students[1] = student2;

    // Create a university and allocate memory for departments
    struct University my_uni;
    strcpy(my_uni.name, "UET LAHORE");
    my_uni.departments = (struct Department*)malloc(1 * sizeof(struct Department));
    my_uni.numDepartments = 1;

    // Add the department to the university
    my_uni.departments[0] = my_dep;

    // Print university information
    printUniversityInfo(&my_uni);

    // Free allocated memory
    free(my_dep.students);
    free(my_uni.departments);

    return 0;
}

// Function definitions
float calculateAverage(struct Student* s) {
    float sum = 0;
    for (int i = 0; i < 3; i++) {
        sum += s->grades[i];
    }
    return sum / 3;
}

void printStudentInfo(struct Student* s) {
    printf("  Name: %s\n", s->name);
    printf("  ID: %d\n", s->id);
    printf("  Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);
    printf("  Average Grade: %.2f\n", calculateAverage(s));
}

void printDepartmentInfo(struct Department* d) {
    printf("Department Name: %s\n", d->name);
    printf("Number of Students: %d\n", d->numStudents);
    for (int i = 0; i < d->numStudents; i++) {
        printf("Student %d:\n", i + 1);
        printStudentInfo(&d->students[i]);
    }
}

void printUniversityInfo(struct University* u) {
    printf("University Name: %s\n", u->name);
    printf("Number of Departments: %d\n", u->numDepartments);
    for (int i = 0; i < u->numDepartments; i++) {
        printDepartmentInfo(&u->departments[i]);
    }
}
*/





//Task 6.4

/*
#include<stdio.h>

union DATA {
    int i;
    float f;
    char c;
    char str[56];
};
int main()
{
    union DATA my_data;
    my_data.i = 10;
    printf("My Integer data is: %d\n",my_data.i);

    my_data.f = 3.45;
    printf("My float data is: %f\n",my_data.f);


    my_data.c = 'A';
    printf("My character data is: %c\n",my_data.c);

    strcpy(my_data.str,"I love C Programming.");
    printf("My string data is: %s\n",my_data.str);
    return 0;

}
*/

