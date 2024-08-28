# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall

EXE = booth maze template_code_Part1

# Default target
all: $(EXE)

booth: booth.c
	$(CC) $(CFLAGS) booth.c -o booth
	./booth

maze: maze.c
	$(CC) $(CFLAGS) maze.c -o maze
	./maze

template_code_Part1: template_code_Part1.c
	$(CC) $(CFLAGS) template_code_Part1.c -o template_code_Part1
	./template_code_Part1

# Making aliases
module2: template_code_Part1

# Clean up the directory
clean:
	rm -f $(EXE)