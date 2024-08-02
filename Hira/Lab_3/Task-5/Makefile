# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall

# Debug flags
DEBUG_FLAGS = -g

# Target executable
TARGET = program

# Source files
SRCS = $(wildcard *.c)

# Object files
OBJS = $(SRCS:.c=.o)

# Dependency files
DEPS = $(SRCS:.c=.d)

# Default target
all: $(TARGET)

# Rule to create the target executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

# Rule to create object files and dependency files
%.o: %.c
	$(CC) $(CFLAGS) -MMD -c $< -o $@

# Include the dependency files
-include $(DEPS)

# Debug target to compile with debugging symbols
debug: CFLAGS += $(DEBUG_FLAGS)
debug: clean all

# Clean target to remove compiled files
clean:
	rm -f $(OBJS) $(TARGET) $(DEPS)

