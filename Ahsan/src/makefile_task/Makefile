CC=gcc
CFLAGS=-I.

# Define all targets
all: main

# Link the object files into the main executable
main: main.o functions.o
	$(CC) -o main main.o functions.o

# Compile main.c to main.o
main.o: main.c
	$(CC) -c main.c $(CFLAGS)

# Compile functions.c to functions.o
functions.o: functions.c
	$(CC) -c functions.c $(CFLAGS)

# Clean the build directory
clean:
	rm -f *.o main

