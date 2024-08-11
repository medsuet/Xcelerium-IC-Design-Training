//Part 7: File I/O
//Task 7.1


/*
#include<stdio.h>
struct Student{
    char name[34];
    int age;
    float marks;
};

//Function prototypes
void writeStudentToFile(struct Student* s, const char* filename);

void readStudentFromFile(struct Student* s, const char* filename);
int main()
{
    struct Student stu = {"John",21,45.6};
    const char* filename = "file1.txt";
    writeStudentToFile(&stu,filename);
    readStudentFromFile(&stu,filename);

    printf("Name: %s\n",stu.name);
    printf("Age: %d\n",stu.age);
    printf("marks: %.2f\n",stu.marks);
    return 0;

}


//function declration
void writeStudentToFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a text file
    FILE *fp;
    fp = fopen("file1.txt","w");
    if(fp==NULL)
    {
        printf("File canoot be write");
    }
    fprintf(fp,"%s %d %f",s->name,s->age,s->marks);
    fclose(fp);
}

void readStudentFromFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a text file
    FILE *fp;
    fp = fopen("file1.txt","r");
    if(fp==NULL)
    {
       printf("File canoot be read");
    }
    fscanf(fp,"%s %d %f",s->name,&s->age,&s->marks);
    fclose(fp);
}
*/



//Task 7.2




/*

#include <stdio.h>
struct Student {
    char name[34];
    int age;
    float marks;
};

// Function prototypes
void writeStudentToFile(struct Student* s, const char* filename);
void readStudentFromFile(struct Student* s, const char* filename);

int main() {
    struct Student stu = {"John", 21, 45.6};
    const char* filename = "file1.bin";

    writeStudentToFile(&stu, filename);
    readStudentFromFile(&stu, filename);

    printf("Name: %s\n", stu.name);
    printf("Age: %d\n", stu.age);
    printf("Marks: %.2f\n", stu.marks);

    return 0;
}

// Function definitions
void writeStudentToFile(struct Student* s, const char* filename) {
    FILE *fp = fopen(filename, "wb");
    if (fp == NULL) {
        printf("File cannot be written\n");
        return;
    }
    fwrite(s, sizeof(struct Student), 1, fp);
    fclose(fp);
}

void readStudentFromFile(struct Student* s, const char* filename) {
    FILE *fp = fopen(filename, "rb");
    if (fp == NULL) {
        printf("File cannot be read\n");
        return;
    }
    fread(s, sizeof(struct Student), 1, fp);
    fclose(fp);
}
*/



//Task 7.3



#include<stdio.h>
#include<time.h>

void logMessage(const char* message, const char* logfile);
void displayLog(const char* logfile);
int main()
{
    const char* logfile = "logfile.txt";
    logMessage("This is 1st log msg.",logfile);
    logMessage("This is 2nd log msg.",logfile);
    displayLog(logfile);
    return 0;
}


void logMessage(const char* message, const char* logfile) {
    // Append a timestamped message to the log file
    FILE* fp = fopen(logfile,"a");
    if (fp == NULL) {
        printf("Error opening log file for writing.\n");
        return; // Exit function if file opening fails
    }

    time_t now = time(NULL);
    fprintf(fp, "[%s] %s\n", ctime(&now), message); // Ensure newline at the end
    fclose(fp);
}

void displayLog(const char* logfile) {
    // Read and display the contents of the log file
    FILE *fp = fopen(logfile, "r");
    if (fp == NULL) {
        printf("Error opening log file for reading.\n");
        return; // Exit function if file opening fails
    }

    char line[256];
    while (fgets(line, sizeof(line), fp)) {
        // Use printf to avoid adding an extra newline
        printf("%s", line);
    }

    fclose(fp);
}
