#include <stdio.h>
#include <stdlib.h>
typedef struct{
    char name[50];
    int id;
    float grades[3];
}Student;

void inputStudentData(Student* s);
float calculateAverage(Student*s);
void printStudeninfo(Student* s);
int main() {
    float Average;
    // Allocate memory for the Student struct
    Student* s = (Student*)malloc(sizeof(Student));
    if (s == NULL) {
        printf("Memory allocation failed\n");
        return 1;
    }
    
    inputStudentData(s);
    Average=calculateAverage(s);
    printf("Average = %f",Average);
    printStudeninfo(s);
    // Free the allocated memory
    free(s);
    return 0;
}
void inputStudentData(Student* s){
    printf("Enter Name of the student ");
    scanf("%49s",s->name);
    printf("Enter ID of the student ");
    scanf("%d",&(s->id));
    printf("Enter Grade of subject 1 of the student ");
    scanf("%f",&(s->grades[0]));
    printf("Enter Grade of subject 2 of the student ");
    scanf("%f",&(s->grades[1]));
    printf("Enter Grade of subject 3 of the student ");
    scanf("%f",&(s->grades[2]));
}
float calculateAverage(Student*s){
    float Average;
    Average=(s->grades[0]+s->grades[1]+s->grades[2])/3;
    return Average;
}
void printStudeninfo(Student* s){
    printf("\nStudent's Name: %s",s->name);
    printf("\nStudent's ID: %d",s->id);
    printf("\nStudent's Grade in subject 1: %f",s->grades[0]);
    printf("\nStudent's Grade in subject 2: %f",s->grades[1]);
    printf("\nStudent's Grade in subject 3: %f",s->grades[2]);
}
