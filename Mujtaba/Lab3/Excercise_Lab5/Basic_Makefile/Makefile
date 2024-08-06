# _*_ Makfile _*_
all: main

main: main.o functions.o
	gcc main.o functions.o -o main

main.o: main.c
	gcc -c main.c 

functions.o: functions.c
	gcc -c functions.c 

.PHONY: all clean
clean:
	rm *.o main

