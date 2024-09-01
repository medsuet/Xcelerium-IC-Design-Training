# _*_ Makefile _*_

all: memory_maze template_code_Part1 Booth_Multiplier

memory_maze: memory_maze.o
	@gcc memory_maze.o -o memory_maze

template_code_Part1: template_code_Part1.o
	@gcc template_code_Part1.o -o template_code_Part1

Booth_Multiplier: Booth_Multiplier.o
	@gcc Booth_Multiplier.o -o Booth_Multiplier

.PHONY: clean all run maze BoothMul

clean:
	@rm *.o template_code_Part1 memory_maze Booth_Multiplier

run: 
	@./template_code_Part1

maze:
	@./memory_maze

BoothMul: 
	@./Booth_Multiplier
