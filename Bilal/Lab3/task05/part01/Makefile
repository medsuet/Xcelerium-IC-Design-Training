# Compiler
CC = gcc
# Compiler flags
CFLAGS = -Wall

# Executable name
TARGET = myprogram

# Source files
SRCS = main.c functions.c
# Object files
OBJS = $(SRCS:.c=.o)

# Default target
all: $(TARGET)

# Linking object files to create executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)

# Compiling each source file into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean target to remove object files and executable
clean:
	rm -f $(OBJS) $(TARGET)

# Individual object files target (for testing)
objects: $(OBJS)

# Phony targets
.PHONY: all clean objects

