# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -O2

# List of source files
SRC = memoryMaze.c lab2.c boothMultiplier.c

# List of object files (derived from source files)
OBJ = $(SRC:.c=.o)

# Executable names
EXEC = memoryMaze lab2 boothMultiplier

# Default target
all: $(EXEC)

# Compile each source file into its corresponding object file
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Link object files to create executables
memoryMaze: memoryMaze.o
	$(CC) $(CFLAGS) $^ -o $@

lab2: lab2.o
	$(CC) $(CFLAGS) $^ -o $@

boothMultiplier: boothMultiplier.o
	$(CC) $(CFLAGS) $^ -o $@

# Run all executables
run: $(EXEC)
	./memoryMaze
	./lab2
	./boothMultiplier

# Run specific executable
run-memoryMaze: memoryMaze
	./memoryMaze

run-lab2: lab2
	./lab2

run-boothMultiplier: boothMultiplier
	./boothMultiplier

# Clean up build files
clean:
	rm -f *.o $(EXEC)

.PHONY: all run run-memoryMaze run-lab2 run-boothMultiplier clean
