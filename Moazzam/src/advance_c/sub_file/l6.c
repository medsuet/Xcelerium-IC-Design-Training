#include <stdio.h>


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
    int i;

    printf("\nEnter Student's Name: ");
    scanf("%s",s->name);
    printf("\nEnter Student ID: ");
    scanf("%d",&(s->id));
    for (i=0; i<3; i++)
    {
        printf("Enter Grade for Subject %d: ",i);
        scanf("%f",&(s->grades[i]));
    }
}



float calculateAverage(struct Student* s) {
    // TODO: Implement this function
    int i;
    float sum = 0;

    for (i=0; i<3; i++)
    {
        sum += s->grades[i];
    }

    return (sum/3);
}

void printStudentInfo(struct Student* s) {
    // TODO: Implement this function
    int i;

    printf("\nStudent's name: %s",s->name);
    printf("\nStudent's ID: %d",s->id);

    for (i=0; i<3; i++)
    {
        printf("\nGrade in Subject %d: %f",i,s->grades[i]);
    }
    printf("\n");
}

int main(){
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4

    struct Student student;

    inputStudentData(&student);

    printf("The average grade is: %f",calculateAverage(&student));

    printStudentInfo(&student);
  
    return 0;
}