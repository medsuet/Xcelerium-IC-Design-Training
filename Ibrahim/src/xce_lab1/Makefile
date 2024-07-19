# Makefile for compiling and running lab1.c

# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall -Wextra -std=c11

# Target executable name
TARGET = lab1

# Source file
SRC = lab1.c

# Default target: compile the program
all: $(TARGET)

# Compile the source file into the target executable
$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)

# Run the compiled program
run: $(TARGET)
	./$(TARGET)

# Clean up compiled files
clean:
	rm -f $(TARGET)

.PHONY: all run clean
