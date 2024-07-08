CC = gcc
CFLAGS = -Wall -Wextra -g

.PHONY: all clean

all: part0 part1 maze #boothMultiplier

part0: src/Part0.c
	$(CC) $(CFLAGS) -o part0 src/Part0.c

part1: src/Part1.c
	$(CC) $(CFLAGS) -o part1 src/Part1.c

maze: src/maze.c
	$(CC) $(CFLAGS) -o maze src/maze.c

boothMultiplier: src/Booth_Multiplier.c
	$(CC) $(CFLAGS) -o boothMultiplier src/Booth_Multiplier.c

clean:
	rm -f part0 part1 boothMultiplier maze
