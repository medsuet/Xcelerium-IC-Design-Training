# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall
DEGUG_F = -g

# Target executable
TARGET = myprogram

# Source and Object files
SRC = $(wildcard *.c) # to include all .c files
OBJ = $(SRC:.c=.o) # every .c file will have .o file


# Default target
all: $(TARGET)
	./$(TARGET) # to run the executable files

# TARGET will be executable of name myprogram from 2 obj files
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)

#OBJ will be .o files of same name as .c files w/ .o extension
$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c $(SRC)

# removing .o files i.e OBJ and executable files i.e TARGET
clean:
	rm -f $(OBJ) $(TARGET)