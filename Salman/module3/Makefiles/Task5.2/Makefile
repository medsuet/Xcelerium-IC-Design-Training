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

# Debug target
debug: CFLAGS += $(DEBUG_FLAGS)
debug: clean $(TARGET)

# Link object files to create the executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

$(OBJS): $(SRCE)
	$(CC) $(CFLAGS) -c $(SRCE)

# Clean up build files
clean:
	rm -f $(OBJS) $(TARGET) *.d

# Phony targets
#.PHONY: all clean

# Dependency tracking
-include $(SRCS:.c=.d)

%.d: %.c
	@$(CC) -MM $(CFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$


