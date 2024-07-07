all: execute
	@echo "Done!"
execute: main.o functions.o
	gcc main.o functions.o -o execute
main.o: main.c
	gcc -c main.c -o main.o
functions.o: functions.c
	gcc -c functions.c -o functions.o
clean:
	rm -f execute main.o functions.o