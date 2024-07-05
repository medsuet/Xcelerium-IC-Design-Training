all : main

main : main.o functions.o
	gcc -o main main.o functions.o -lm

main.o : main.c
	gcc -c main.o main.c

functions.o : functions.c
	gcc -c functions.o functions.c

debug:
	gcc -d -o main main.o functions.o -lm

clean :
	@rm -f *.o