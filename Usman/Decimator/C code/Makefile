# Extract the base filename (without the .c extension) from the input
FILE = $(basename $(firstword $(MAKECMDGOALS)))

# Compile the C file
compile:
	gcc $(FILE).c -o $(FILE)

# Run the compiled program
run: compile
	./$(FILE)

# Clean the generated executable
clean:
	rm -f $(FILE)

# This line avoids treating the .c file as a Makefile target
%:
	@:

