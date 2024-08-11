CC = gcc
CFLAGS = -Wall

all: my_program
my_program: main.o function.o
	$(CC) $(CFLAGS) main.o function.o -o my_program

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

function.o:function.c
	$(CC) $(CFLAGS) -c function.c -o function.o

clean:
	rm -f *.o my_program
