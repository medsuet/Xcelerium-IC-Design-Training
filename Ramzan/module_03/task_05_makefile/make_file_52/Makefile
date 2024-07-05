CC = gcc
CFLAGS = -Wall -Wextra

#Now we have to search all c files in our currebt directory
SRC = $(wildcard *.c)
#Now we have to convert all .c files into .o
OBJ = $(SRC:.c=.o)

EXEC = my_program

all: $(EXEC)
$(EXEC): $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $(EXEC)
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

debug: CFLAGS+=-g
debug: clean all

clean:
	rm -f $(OBJ) $(EXEC)

