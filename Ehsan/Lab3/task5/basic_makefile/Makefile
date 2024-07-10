COMPLIER = gcc
COMPLIER_FLAGS = -Wall

all : main

main : main.o functions.o
	$(COMPLIER) -o main.o functions.o

main.o : main.c 
	$(COMPLIER) $(COMPLIER_FLAGS) -c main.c

functions.o : functions.c
	$(COMPLIER) $(COMPLIER_FLAGS) -c functions.c

clean :
	rm -rf main functions *.o

