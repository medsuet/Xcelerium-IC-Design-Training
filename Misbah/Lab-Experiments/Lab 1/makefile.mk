# Compiler
CC = gcc

#Flags
CLAGS = -Wall -g

#Target executable
TARGET = Lab1

#SRC files
SRCS = Lab1.c lab1_functions.c

#Object files
OBJS = Lab1.o

#Target
all: $(TARGET)

#Linking
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)

#Compiling 
%.o: %.c
	$(CC) $(CFLAGS) -c Lab1.c -o Lab1.o

#Clean up
clean:
	rm -f $(OBJ) $(TARGET)

#PHONY targets
.PHONY: all clean
