#include<stdio.h>
//Task 0.4 Functions

//part(a)
//Programme to find prime number

int main()
{
    int i, j, isPrime;
    for(i = 2; i <= 100; i++)
    {
        isPrime = 1;
        for(j = 2; j < i; j++)
        {
            if(i % j == 0)
            {
                isPrime = 0;
                break;
            }
        }
        if(isPrime == 1)
        {
            printf("%d ", i);
        }
    }
    printf("\n");
    return 0;
}


//part(b)
//Programme to find Fictoril


int Fictorial(int num);

int main()
{
    int x;
    printf("Enter a number:");
    scanf("%d",&x);
    Fictorial(x);

}
int Fictorial(int num)
{
    int fic = 1;
    for (int i=1;i<=num;i++)
    {
        fic = fic*i;

    }
    printf("Fictorial is:%d\n",fic);
    return 0;
}


