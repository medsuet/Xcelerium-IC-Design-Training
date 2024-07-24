SRCS_DIR := src
OBJ_DIR := obj

SRCS := $(wildcard ./$(SRCS_DIR)/*.c)
OBJS := $(patsubst ./$(SRCS_DIR)/%.c, ./$(OBJ_DIR)/%.o, $(SRCS))

all: compile run

compile: $(SRCS)
	@rm -rf obj
	@mkdir obj
	gcc -o ./$(OBJ_DIR)/boothsmutiplier $(SRCS)

debug: $(SRCS)
	@rm -rf obj
	@mkdir obj
	gcc -g -o ./$(OBJ_DIR)/boothsmutiplier $(SRCS)
	gdb -tui ./$(OBJ_DIR)/boothsmutiplier

run:
	./$(OBJ_DIR)/boothsmutiplier

clean:
	rm -rf obj *.o
