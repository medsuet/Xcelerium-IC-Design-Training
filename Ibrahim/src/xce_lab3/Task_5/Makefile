# Complete Makefile
# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall -Werror

# Source files
SRCS = $(wildcard *.c)

# Object files
OBJS = $(SRCS:.c=.o)

# Target executable
TARGET = main

# Default target
all: $(TARGET)

# Link object files to create the executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

# Compile source files to object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up object files and executable
clean:
	rm -f $(OBJS) $(TARGET) *.d

# Compile with debugging symbols
debug: CFLAGS += -g
debug: $(TARGET)

# Include dependency files
-include $(SRCS:.c=.d)

# Generate dependency files
%.d: %.c
	@$(CC) $(CFLAGS) -MM $< > $@.tmp
	@sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.tmp > $@
	@rm -f $@.tmp

