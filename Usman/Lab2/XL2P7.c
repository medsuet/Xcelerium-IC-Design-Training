#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

struct Student {
    char name[50];
    int id;
    float grades[3];
};

// Function to write student data to a text file
void writeStudentToFile(struct Student* s, const char* filename) {
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }
    
    fprintf(file, "Name: %s\n", s->name);
    fprintf(file, "ID: %d\n", s->id);
    fprintf(file, "Grades: %.2f %.2f %.2f\n", s->grades[0], s->grades[1], s->grades[2]);

    fclose(file);
}

// Function to read student data from a text file
void readStudentFromFile(struct Student* s, const char* filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }

    fscanf(file, "Name: %[^\n]\n", s->name);
    fscanf(file, "ID: %d\n", &s->id);
    fscanf(file, "Grades: %f %f %f\n", &s->grades[0], &s->grades[1], &s->grades[2]);

    fclose(file);
}

// Function to write student data to a binary file
void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    FILE *file = fopen(filename, "wb");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }

    fwrite(s, sizeof(struct Student), 1, file);
    fclose(file);
}

// Function to read student data from a binary file
void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    FILE *file = fopen(filename, "rb");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }

    fread(s, sizeof(struct Student), 1, file);
    fclose(file);
}

// Function to append a timestamped message to the log file
void logMessage(const char* message, const char* logfile) {
    FILE *file = fopen(logfile, "a");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }

    time_t now = time(NULL);
    char *timestamp = ctime(&now);
    timestamp[strlen(timestamp) - 1] = '\0';  // Remove newline character

    fprintf(file, "[%s] %s\n", timestamp, message);
    fclose(file);
}

// Function to read and display the contents of the log file
void displayLog(const char* logfile) {
    FILE *file = fopen(logfile, "r");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }

    char buffer[255];
    while (fgets(buffer, 255, file)) {
        printf("%s", buffer);
    }

    fclose(file);
}

// Main function for testing
int main() {
    struct Student student = {"John Doe", 1, {85.5, 90.0, 88.5}};

    // Test text file functions
    writeStudentToFile(&student, "student.txt");
    struct Student studentFromFile;
    readStudentFromFile(&studentFromFile, "student.txt");
    printf("Read from text file:\nName: %s\nID: %d\nGrades: %.2f %.2f %.2f\n\n",
    studentFromFile.name, studentFromFile.id, studentFromFile.grades[0], studentFromFi    le.grades[1], studentFromFile.grades[2]);

    // Test binary file functions
    writeStudentToBinaryFile(&student, "student.bin");
    struct Student studentFromBinaryFile;
    readStudentFromBinaryFile(&studentFromBinaryFile, "student.bin");
    printf("Read from binary file:\nName: %s\nID: %d\nGrades: %.2f %.2f %.2f\n\n",
    studentFromBinaryFile.name, studentFromBinaryFile.id, 
    studentFromBinaryFile.grades[0], studentFromBinaryFile.grades[1], studentFromBinaryFile.grades[2]);

    // Test logging functions
    logMessage("Program started", "logfile.txt");
    logMessage("Performed some operations", "logfile.txt");
    logMessage("Program ended", "logfile.txt");
    printf("Log file contents:\n");
    displayLog("logfile.txt");

    return 0;
}

