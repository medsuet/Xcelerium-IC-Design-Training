# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall 
DEGUG_F = -g

# Target executable
TARGET = myprogram

# Source and Object files
SRCE = $(wildcard *.c)
OBJS = $(SRCE:.c=.o)


# Default target
all: $(TARGET)
	./$(TARGET)

# Link object files to create the executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

$(OBJS): $(SRCE)
	$(CC) $(CFLAGS) -c $(SRCE)

# Clean up build files
clean:
	rm -f $(OBJS) $(TARGET)

# Phony targets
#.PHONY: all clean
