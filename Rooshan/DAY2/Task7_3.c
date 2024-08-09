#include <stdio.h>
#include <time.h>
int DisplayLogFlie(char filename[]);
int main () {
    int i=0,num;
    time_t rawtime;
    struct tm *info;
    time( &rawtime );
    info = localtime( &rawtime );
    printf("Current local time and date: %s", asctime(info));

    FILE * LogFile;
    char filename[] = "TextFile_Day2_Task7_3.txt";

    // Open the file for reading
    LogFile = fopen(filename, "w");
    if (LogFile == NULL) {
        printf("Error opening file");
        return 1;
    }
    printf("\nEnter number of messages for file:\n");
    scanf("%d",&num);
    fprintf(LogFile,"Name                Message                Time\n");

    char Name[50];
    char Message[50];
    while(i<num){
        time( &rawtime );
        info = localtime( &rawtime );
        printf("Enter Name: ");
        scanf(" %49s",Name);
        printf("Enter Message: ");
        scanf(" %49s",Message);
        fprintf(LogFile,"%s             %s             %s\n",Name,Message,asctime(info));
        i++;
    }
    fclose(LogFile);
    DisplayLogFlie(filename);
    return(0);
}
int DisplayLogFlie(char filename[]){
    FILE * file;
    char buffer[256];

    // Open the file for reading
    file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error opening file");
        return 1;
    }

    while (fgets(buffer, sizeof(buffer), file) != NULL) {
        printf("%s", buffer);
    }

    // Close the file
    fclose(file);
    return 1;
}