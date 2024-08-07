# Compiler
CC = gcc
# Compiler flags
CFLAGS = -Wall

# Source files
SRCS = main.c functions.c
# Object files
OBJS = $(SRCS:.c=.o)
# Executable name
TARGET = myprogram

# Default target
all: $(TARGET)

# Rule to link object files into executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)

# Rule to compile C files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Target to clean object files and executable
clean:
	rm -f $(OBJS) $(TARGET)
