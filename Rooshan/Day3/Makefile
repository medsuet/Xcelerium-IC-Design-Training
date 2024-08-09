# Compiler
CC = gcc

# Compiler flags (include current directory and enable dependency tracking)
CFLAGS = -I. -MMD -MP

# Debugging flags
DEBUGFLAGS = -g

# Source files (all .c files present in the current directory)
SRCS = $(wildcard *.c)

# Object files (replace .c with .o)
OBJS = $(SRCS:.c=.o)

# Dependency files (replace .c with .d)
DEPS = $(SRCS:.c=.d)

# Default target: Build the executable
all: MakeFileTask5_1

# Link the object files to create the executable
MakeFileTask5_1: $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

# Compile source files to object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Debug target: Compile with debugging symbols
debug: CFLAGS += $(DEBUGFLAGS)
debug: clean all

# Run the program
run: all
	./MakeFileTask5_1

# Clean up: Remove executable, object files, and dependency files
clean:
	rm -f MakeFileTask5_1 $(OBJS) $(DEPS)

# Include the dependency files
-include $(DEPS)
