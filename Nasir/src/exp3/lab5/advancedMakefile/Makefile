# Variables
CC = gcc
CFLAGS = -Wall
DEBUGFLAGS = -g
SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
DEP = $(SRC:.c=.d)
TARGET = myprogram

# Targets
all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)

debug: CFLAGS += $(DEBUGFLAGS)
debug: clean $(TARGET)

-include $(DEP)

%.o: %.c
	$(CC) $(CFLAGS) -MMD -c $< -o $@

clean:
	rm -f $(OBJ) $(TARGET) $(DEP)

.PHONY: all debug clean
