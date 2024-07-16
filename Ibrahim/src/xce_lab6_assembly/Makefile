# Makefile for RISC-V Assembly Exercises
# Compiler and emulator
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
SPIKE = spike

# List of programs with directories
PROGS = Problems/Problem_1/problem_1 Problems/Problem_2/problem_2 Problems/Problem_3/problem_3 Problems/Problem_4/problem_4 Problems/Problem_5/problem_5

# Default target
all: $(PROGS)

# Rule to assemble and link each program
$(PROGS): %: %.s
	$(AS) -o $@.o $<
	$(LD) -T $(@D)/link.ld -o $@ $@.o

# Rule to run a specific program with Spike
run: 
	@echo "Usage: make run PROG=<problem_name>"
	@echo "Example: make run PROG=Problems/Problem_1/problem_1"

ifeq ($(PROG),)
run-%:
	@echo "Please specify a program using PROG=..."
else
run:
	$(SPIKE) $(PROG)
endif

# Rule to debug a specific program with Spike
debug:
	@echo "Usage: make debug PROG=<problem_name>"
	@echo "Example: make debug PROG=Problems/Problem_1/problem_1"

ifeq ($(PROG),)
debug-%:
	@echo "Please specify a program using PROG=..."
else
debug:
	$(SPIKE) -d --log-commits $(PROG)
endif

# Clean up
clean:
	rm -f Problems/Problem_1/*.o Problems/Problem_2/*.o Problems/Problem_3/*.o Problems/Problem_4/*.o Problems/Problem_5/*.o Problems/Problem_1/problem_1 Problems/Problem_2/problem_2 Problems/Problem_3/problem_3 Problems/Problem_4/problem_4 Problems/Problem_5/problem_5

.PHONY: all run debug clean
