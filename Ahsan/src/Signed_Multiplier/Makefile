# Makefile for Systemverilog code

# Compiler and flags
CC = iverilog
CFLAGS = -g2012

# Default target
all:
	$(CC) $(CFLAGS) -o out.vvp tb.sv Sign_multiplier.sv Half_adder.sv Full_adder.sv

# Rule to run the program
run:
	vvp out.vvp

clean:
	rm -f *.vvp

.PHONY: all run clean
