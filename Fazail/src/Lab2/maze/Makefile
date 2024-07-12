SRC_DIR = src
OBJ_DIR = obj

SRC := $(wildcard ./$(SRC_DIR)/maze.c)
OBJ := $(patsubst ./$(SRC_DIR)/*.c, ./$(OBJ_DIR)/*.o, $(SRC))

all: compile test

compile: $(SRC)
	rm -rf obj
	mkdir obj
	gcc -o ./$(OBJ_DIR)/maze $(SRC)

test: compile
	./obj/maze

debug:
	rm -rf obj
	mkdir obj
	gcc -o -g ./$(OBJ_DIR)/maze $(SRC)

clean:
	rm -rf obj *.log
