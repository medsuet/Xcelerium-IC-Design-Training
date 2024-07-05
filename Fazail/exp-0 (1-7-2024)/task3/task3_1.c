#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    srand(time(NULL));
    int rand_value; //random Value
    int user_input; //user input

    rand_value = (rand() % 100 + 1);

    printf("Type the initial guess:%d", rand_value);
    scanf("%d", &user_input);

    while(user_input != rand_value)
    {
        if (user_input < rand_value) {
            printf("Your guess is low\n");
            printf("Guess a new value:");
	    scanf("%d", &user_input); }
        else {
	    printf("Your guess is high\n");
	    printf("Guess a new value:");
	    scanf("%d", &user_input);}
    }
    printf("Your Value matched. CONGRATULATIONS!!!\n");
    return 0;
}
