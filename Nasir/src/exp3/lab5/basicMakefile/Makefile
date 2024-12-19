# Variables
CC = gcc
CFLAGS = -Wall -g
OBJ = main.o function.o
TARGET = myprogram

# Targets
all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)

main.o: main.c function.c
	$(CC) $(CFLAGS) -c main.c

function.o: function.c function.c
	$(CC) $(CFLAGS) -c function.c

clean:
	rm -f $(OBJ) $(TARGET)
