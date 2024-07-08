# Compiler
CC = gcc
# Compiler flags
CFLAGS = -Wall
# Debugging symbols flag
DEBUG_FLAGS = -g

# Executable name
TARGET = myprogram

# Source files (automatically find all .c files)
SRCS := $(wildcard *.c)
# Object files (generated from source files)
OBJS := $(SRCS:.c=.o)
# Dependency files
DEPS := $(OBJS:.o=.d)

# Default target
all: $(TARGET)

# Linking object files to create executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)

# Compiling each source file into object files with dependency tracking
%.o: %.c
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

# Include dependencies
-include $(DEPS)

# Clean target to remove object files, dependency files, and executable
clean:
	rm -f $(OBJS) $(DEPS) $(TARGET)

# Debug target with debugging symbols
debug: CFLAGS += $(DEBUG_FLAGS)
debug: clean all

# Phony targets
.PHONY: all clean debug

