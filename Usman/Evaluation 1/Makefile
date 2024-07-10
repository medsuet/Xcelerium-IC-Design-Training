CC = gcc
CFLAGS = -Wall -I

all: Evaluation

Evaluation: Evaluation.o
	$(CC) $(CFLAGS) -o Evaluation Evaluation.o

Evaluation.o: Evaluation.c
	$(CC) $(CFLAGS) -c  Evaluation.c

Run:
	./Evaluation
clean:
	rm -f Evaluation Evaluation.o
