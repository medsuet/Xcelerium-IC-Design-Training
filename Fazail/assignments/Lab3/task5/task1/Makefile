CC = gcc
CFLAGS = -Wall

all: main

main: main.o functions.o
	$(CC) -o main main.o
	$(CC) -o functions functions.o

main.o function.o: main.c functions.c
	$(CC) $(CFLAGS) -c main.c
	$(CC) $(CFLAGS) -c functions.c

clean:
	rm -rf main functions *.o
