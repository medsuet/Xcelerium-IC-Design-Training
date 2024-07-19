#include <stdio.h>

int main() {
    int number;
    int bitLocation;
    int new_number;
    char type;
    char answer;
    
    // Enter a number first 
    printf("Enter a number: ");
    scanf("%d", &number);

    do {
        // Asking user whether to clear or set a particular bit in the given number
        printf("Type S for set and C for clearing a bit: ");
        scanf(" %c", &type);

        // Asking for location of a particular bit which is to be set(1) or cleared(0)
        printf("Enter bit number you want to set or clear (between 0 and 31): ");
        scanf("%d", &bitLocation);
        // If user wants to set a bit, perform the following
        if (type == 'S') {
            // left shift 1 to the location where we want to set a bit
            new_number = (1 << bitLocation);
            // OR that particular set bit with original number to set that bit in original number
            number = (new_number | number);
        }
        // If user wants to clear a bit, perform the following
        else if (type == 'C') {
            // left shift 1 by to the location where we want to clear a bit(make that bit 0 by NOT)
            new_number = ~(1 << bitLocation);
            // AND that particular clear bit(0) with original number to clear that bit in original number 
            number = (new_number & number);
        }
    
        // Print the number after setting or clearing a bit
        printf("Number after clearing or setting %d bit: %d\n", bitLocation, number);
        
        // Ask user whether to continue or not
        printf("Do you want to continue to set or clear a bit?(Y for Yes, N for No): ");
        scanf(" %c", &answer);

    } while(answer == 'Y');
}