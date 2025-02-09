#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <assert.h>

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

void studentData(struct Student *student){
    
    // This function is use to add data maually in the 
    // the struct stucdent only
    printf("Enter the name of Student: ");
    fgets(student->name, sizeof(student->name), stdin);

    // When i use scanf it stucks, if the name is very small and 
    // if i enter the with spacing like 'Fazail Ali Butt' it only 
    // pick the first name of this string.

    //scanf("%s",student->name);

    printf("Enter the student id: ");
    scanf("%d",&student->id);

    // fgets is used to read a string from the standerd input
    //fgets(student->id, sizeof(student->id), stdin);

    // Assign grades manually
    student->grades[0] = (float) 12.14;
    student->grades[1] = (float) 23.24;
    student->grades[2] = (float) 35.39;
}

void printArrayAndSize(int* arr, int size){

    // Print the array using for loop
    printf("Your array is: \n   [ ");
    for(int i=0; i<size; i++){
        printf("%d ", *(arr+i));
    }
    printf("]\n");
}

void arrayAverage(float num, int den){
    float avg = num / (float)den;
    printf("The average of the array: %.2f\n",avg);
}

union Data {
    int i;
    float f;
    char c;
};

/*void writeBinaryFormat(struct Student* s, const char* filename) {

    FILE *file

    file = fopen(filename,"wb");
    if(file == NULL) {
        perror("Error opening file");
        return -1;
    }
    
    //fread();
    //fwrite ();
}*/

void writeStudentToFile(struct Student* s, const char* filename) {
    
    int count = 0 ;
    // file pointer declared
    FILE *file_ptr;

    // file open
    //file_ptr = fopen("firstFile.txt", "w");
    file_ptr = fopen(filename, "w");

    // failed condition
    if (file_ptr == NULL){
        printf("Error Occurred While creating a file !\n");
        exit(1);
    }

    // Write student data to a text file
    fprintf(file_ptr, "====== Student's Information ======\n");
    fprintf(file_ptr, "  Name  : %s\n",s->name);
    fprintf(file_ptr, "  Id    : %d\n",s->id);

    fprintf(file_ptr, "  Grades: [ ");
    for(int i=0; i<3; i++) {
        fprintf(file_ptr, "%.2f ",s->grades[i]);    
    }    
    fprintf(file_ptr," ]\n");

    fclose(file_ptr);

    // Data is finally Inserted
    printf("\nFile created.\n\n");
}

void readStudentFromFile(struct Student* s, const char* filename) {

    FILE *file = fopen("Student Information.txt", "r");
    if (file == NULL) {
        printf("Could not open file students.txt for reading\n");
        exit;
    }

    char *line = NULL; // Pointer to hold the line read from the file
    size_t len = 0;    // Initial length of the buffer
    size_t read ;      // Number of characters read

    // Read each line from the file
    //printf("%ld \n",getline(&line, &len, file));
    while ((read = getline(&line, &len, file)) != -1) {
        printf("%s", line); // Print the line to the terminal
    }

    // Free the allocated memory for line
    free(line);

    // Close the file
    fclose(file);
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a binary file
    FILE *fptr;
    int i;
    size_t elementsWritten;
    char str[20];

    fptr = fopen("Student-Information.txt", "wb");

    if (fptr == NULL)
    {
        printf("File failed to open!");
        exit(0);
    }

    printf("\nWriting Student's Record");
    size_t nameLength = strlen(s->name) + 1; // adding 1 to include the null terminator in the end
    elementsWritten = fwrite(s->name,sizeof(char),nameLength,fptr);

    if (elementsWritten != nameLength)
    {
        printf("\nError writing Student's Name");
        fclose(fptr);
        exit(0);
    }

    sprintf(str, "%d", s->id); // converting integer to string since fwrite works only on integers
    elementsWritten = fwrite("\n",sizeof(char),strlen("\n"),fptr); // adding new line myself
    elementsWritten = fwrite(str,sizeof(char),strlen(str),fptr);

    if (elementsWritten != strlen(str))
    {
        printf("\nError writing Student's ID");
        fclose(fptr);
        exit(0);
    }

    for (i=0; i<3; i++) // loop to write grades of 3 subjects
    {

        memset(str, '\0',sizeof(str)); // resetting the string, \0 is considered as a null
        sprintf(str, "%.2f", s->grades[i]);
        elementsWritten = fwrite("\n",sizeof(char),sizeof("\n"),fptr);
        elementsWritten = fwrite(str,sizeof(char),sizeof(str),fptr);

        if (elementsWritten != sizeof(str))
        {
            printf("\nError writing Student's Grades");
            fclose(fptr);
            exit(0);
        }

    }
    fclose(fptr);

    printf("\nStudent's Record Written Succesfully\n");

}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file

    FILE *fptr;
    int i;
    char buffer[100];

    fptr = fopen(filename, "rb");

    if (fptr == NULL)
    {
        printf("\nThe file failed to open\n");
        exit(0);
    }
    else
    {
        printf("\nThe file contents are:\n");

        fread(buffer,sizeof(buffer),1,fptr);

        for (i=0; i<strlen(buffer);i++)
        {
            printf("%u ",buffer[i]);
        }
    }

    printf("\n");

    fclose(fptr);

}

void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
    FILE *fptr;

    time_t t = time(NULL);
    struct tm *tm = localtime(&t);
    char timestamp[64];
    size_t ret = strftime(timestamp, sizeof(timestamp), "%c", tm);
    assert(ret);
    printf("%s\n", timestamp);                                  // generating timestamp

    fptr = fopen(logfile, "a");

    if (fptr == NULL)
    {
        printf("Failed to open file");
        exit(0);
    }

    printf("\nAdding message into log file\n");
    strcat(timestamp,": ");                                     // adding space between timestamp and message
    fwrite("\n",sizeof(char),strlen("\n"),fptr);
    fwrite(timestamp,sizeof(char),strlen(timestamp),fptr);      // writing timestamp in beggining and message later
    fwrite(message,sizeof(char),strlen(message),fptr);
    printf("\nAdded the message succesfully\n");

    fclose(fptr);
}

void displayLog(const char* logfile) {
    // TODO: Read and display the contents of the log file
    FILE *fptr;
    int ch;
    fptr = fopen(logfile, "r");

    if (fptr == NULL)
    {
        printf("\nThe file failed to open");
        exit(0);
    }
    else
    {
        printf("\nThe file contents are:\n");
        ch = fgetc(fptr);

        while (ch != EOF)           // loop will stop at End of File EOF
        {
            printf("%c",ch);        // printing character by character
            ch = fgetc(fptr);       // traversing character to next character
        }
    }

    printf("\n");

    fclose(fptr);
}

int main()
{
    
    /* This is just to implement the stucts and Unions.*/
    struct University uni;
    union Data data;
    float sum = 0;
    
    //studentData(&stu);

    strcpy(uni.name, "Uet Lahore");
    uni.numDepartments = 14;

    //First we have to assign the memory of department in univeristy
    uni.departments = (struct Department*) malloc(sizeof(struct Department));
    strcpy(uni.departments->name, "EE Department");

    uni.departments->students = (struct Student *) malloc(sizeof(struct Student));
    strcpy(uni.departments->students->name, "Fazail Ali Butt");
    uni.departments->students->id = 142;
    uni.departments->students->grades[0] = 12;
    uni.departments->students->grades[1] = 22;
    uni.departments->students->grades[2] = 52;

    printf("University name: %s\nNumber of Departments:%d\n\n",            \
            uni.name, uni.numDepartments);

    printf("Department name:%s\nNumber of Students in departments: %d\n\n",\
            uni.departments->name,               \
            uni.departments->numStudents);

    printf("===== Student Information =====\n");

    printf("Student Name  : %s\nStudent Id    : %d\n",                      \
            uni.departments->students->name,        \
            uni.departments->students->id);

    printf("Student Grades: [");

    for (int i=0; i<3; i++){
        // This for loop is use to print the array of grades.
        // And also use to make the sum of all the integers 
        // in the array.
        printf("%.2f ",uni.departments->students->grades[i]);
        sum = sum + uni.departments->students->grades[i];
    }
    
    printf("]\n\n");

    arrayAverage(sum, 3);

    data.i=10;
    data.f=3.14;
    data.c = 'F';

    printf("\n==== UNION ====\ninteger = %d\nFloat = %.2f\nCharacter = %d\n",\
        data.i, data.f, data.c);

    printf("\nMemory size occupied by data:\nChar %zu bytes\nInteger %zu bytes\nFloat %zu bytes\n",\
            sizeof(data.c), sizeof(data.i), sizeof(data.f));

    /* ===================== FILE Input/Output ===================== */

    writeStudentToFile(uni.departments->students, "Student Information");

    readStudentFromFile(uni.departments->students, "Student Information");

    writeStudentToBinaryFile(uni.departments->students, "Student-Information");
    
    readStudentFromBinaryFile(uni.departments->students,"Student-Information");
    
    logMessage("first log","logfile.txt");
    logMessage("Second log","logfile.txt");
    logMessage("Third log","logfile.txt");
    logMessage("4th log","logfile.txt");
    
    displayLog("logfile.txt");
    
    return 0;
}
