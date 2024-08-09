#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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
void printStudeninfo(FILE *binaryfile,Student* s);

int main(){
    University u;
    FILE *binaryfile;
    binaryfile=fopen("Task7_2Binary.dat","wb");
    if (binaryfile==NULL){
        printf("Could not locate file");
        exit(-1);
    }
    printf("Enter University's Name: ");
    scanf("%49s",u.name);
    printf("Enter the number of departments in University: ");
    scanf("%d",&u.numDepartments);
    u.departments=(Department*)malloc(u.numDepartments*sizeof(Department));
    if (u.departments == NULL) {
        printf("Memory allocation failed\n");
        return 1;
    }
    for (int i=0;i<u.numDepartments;++i){
        printf("Enter Department's name: ");
        scanf("%49s",u.departments[i].name);
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
    // Create a buffer to hold the formatted string
    char buffer[150];
    snprintf(buffer, sizeof(buffer), "University's Name: %s\n", u.name);
    fwrite(buffer, sizeof(char), strlen(buffer), binaryfile);
    for (int k=0;k<u.numDepartments;++k){
        snprintf(buffer, sizeof(buffer), "Department's Name: %s\n",u.departments[k].name);
        fwrite(buffer, sizeof(char), strlen(buffer), binaryfile);
        for (int l=0;l<u.departments[k].numStudents;++l){
            printStudeninfo(binaryfile,&(u.departments[k].students[l]));
        }
    }
    fclose(binaryfile);
    FILE *file = fopen("Task7_2Binary.dat", "rb");
    if (file == NULL) {
        printf("Error opening file");
        return 1;
    }

    unsigned char buffer2[100];
    size_t bytes_read;

    while ((bytes_read = fread(buffer2, sizeof(unsigned char), 100, file)) > 0) {
        for (size_t i = 0; i < bytes_read; ++i) {
            printf("%02x ", buffer2[i]);
        }
    }

    fclose(file);

    // Free allocated memory
    for (int i = 0; i < u.numDepartments; ++i) {
        free(u.departments[i].students);
    }
    free(u.departments);

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
void printStudeninfo(FILE *binaryfile,Student* s){
    // Create a buffer to hold the formatted string
    char buffer[150];
    snprintf(buffer, sizeof(buffer),"\nStudent's Name: %s",s->name);
    fwrite(buffer, sizeof(char), strlen(buffer), binaryfile);
    snprintf(buffer, sizeof(buffer),"\nStudent's ID: %d",s->id);
    fwrite(buffer, sizeof(char), strlen(buffer), binaryfile);
    snprintf(buffer, sizeof(buffer),"\nStudent's Grade in subject 1: %f",s->grades[0]);
    fwrite(buffer, sizeof(char), strlen(buffer), binaryfile);
    snprintf(buffer, sizeof(buffer),"\nStudent's Grade in subject 2: %f",s->grades[1]);
    fwrite(buffer, sizeof(char), strlen(buffer), binaryfile);
    snprintf(buffer, sizeof(buffer),"\nStudent's Grade in subject 3: %f",s->grades[2]);
    fwrite(buffer, sizeof(char), strlen(buffer), binaryfile);

}
