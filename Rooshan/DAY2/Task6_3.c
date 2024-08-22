#include <stdio.h>
#include <stdlib.h>
typedef struct {
    char name[50];
    int id;
    float grades[3];
}Student;
typedef struct {
    char name[50];
    Student* students;
    int numStudents;
}Department;
typedef struct {
    char name[100];
    Department* departments;
    int numDepartments;
}University;

void inputStudentData(Student* s);
float calculateAverage(Student*s);
void printStudeninfo(Student* s);


int main(){
    University u;
    printf("Enter University's Name: ");
    scanf(" %49s",&u.name);
    printf("Enter the number of departments in University: ");
    scanf("%d",&u.numDepartments);
    u.departments=(Department*)malloc(u.numDepartments*sizeof(Department));
    if (u.departments == NULL) {
    printf("Memory allocation failed\n");
    return 1;
    }
    for (int i=0;i<u.numDepartments;++i){
        printf("Enter Department's name: ");
        scanf(" %49s",&u.departments[i].name);
        printf("Enter the number of students in department %d in University: ",i);
        scanf("%d",&u.departments[i].numStudents);
        u.departments[i].students=(Student*)malloc(u.departments[i].numStudents*sizeof(Student));
        if (u.departments[i].students == NULL) {
            printf("Memory allocation failed\n");
            return 1;
        }
        for (int j=0;j<u.departments[i].numStudents;++j){
            inputStudentData(&(u.departments[i].students[j]));
        }
    }
    printf("University's Name: %s\n",u.name);
    for (int k=0;k<u.numDepartments;++k){
        printf("Department's Name: %s\n",u.departments[k].name);
        for (int l=0;l<u.departments[k].numStudents;++l){
            printStudeninfo(&(u.departments[k].students[l]));

        }
    }
    return 1;
}
void inputStudentData(Student* s){
    printf("Enter Name of the student ");
    scanf(" %49s",s->name);
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
