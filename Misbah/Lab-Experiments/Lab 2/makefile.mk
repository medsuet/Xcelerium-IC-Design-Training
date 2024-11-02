# Compiler
CC = gcc

#Flags
CLAGS = -Wall -g

#Target executable
TARGET = lab02

#SRC files
SRCS = lab02.c

#Object files
OBJS = lab02.o

#Target
all: $(TARGET)

#Linking
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)

#Compiling 
%.o: %.c
	$(CC) $(CFLAGS) -c lab02.c -o lab02.o

all: $(TARGET)
	./$(TARGET)
#Clean up
clean:
	rm -f $(OBJ) $(TARGET)
#PHONY targets
.PHONY: all clean
