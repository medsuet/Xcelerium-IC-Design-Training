# Makefile for C code

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Werror -g

# Command line variable for program name
PROG ?= main

# Default target
all: $(PROG)

# Rule to compile the program
$(PROG): $(PROG).c
	$(CC) $(CFLAGS) -o $(PROG) $(PROG).c

# Rule to run the program
run: $(PROG)
	./$(PROG)

# Clean up
clean:
	rm -f $(PROG) *.o

.PHONY: all run clean

# Help target to provide usage information
help:
	@echo "Usage:"
	@echo "  make all PROG=<program_name>    - Compile the specified C program"
	@echo "  make run PROG=<program_name>    - Run the specified C program"
	@echo "  make clean                      - Clean up the executable and object files"

