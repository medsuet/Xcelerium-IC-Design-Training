#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main() {
    srand(time(0));
    int random_number=rand()%100+1;
    int Answer=0;
    int Guess;
    printf("Guess the number\n");
    while (Answer!=1){
        printf("Enter the guessed number:\n");
        scanf("%d",&Guess);
        if (Guess<random_number){
            printf("Higher\n");
        }
        else if (Guess>random_number){
            printf("Lower\n");
        }
        else{
            Answer=1;
            printf("Correct");
        }
    }
}