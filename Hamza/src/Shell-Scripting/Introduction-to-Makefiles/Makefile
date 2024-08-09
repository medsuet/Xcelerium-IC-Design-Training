# Variables
CC = gcc
CFLAGS = -Wall -Wextra -std=c11
LDFLAGS =

# Source files and object files
SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
DEPS = $(SRCS:.c=.d)

# Output executable
TARGET = my_program

# Phony targets
.PHONY: all clean debug


# Default target
all: $(TARGET)

# Rule to link object files into the final executable
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

# Rule to compile .c files into .o files and generate dependencies
%.o: %.c
	$(CC) $(CFLAGS) -MMD -o $@ -c $<

# Include dependency files
-include $(DEPS)

# Debug target
debug: CFLAGS += -g
debug: clean all

# Clean target to remove compiled files
clean:
	rm -f $(OBJS) $(DEPS) $(TARGET)


###########################################################


# # Makefile for simple C program

# # Compiler
# CC = gcc

# # Compiler flags
# CFLAGS = -Wall -g

# # Source files
# SRCS = main.c functions.c

# # Object files
# OBJS = main.o functions.o

# # Executable name
# TARGET = program

# # Default target
# all: $(TARGET)

# # Build target
# $(TARGET): $(OBJS)
# 	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

# # Compile source files into object files
# main.o: main.c functions.h
# 	$(CC) $(CFLAGS) -c main.c

# functions.o: functions.c functions.h
# 	$(CC) $(CFLAGS) -c functions.c

# # Clean target
# clean:
# 	rm -f $(OBJS) $(TARGET)
