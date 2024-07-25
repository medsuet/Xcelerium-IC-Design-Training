# Makefile for SystemVerilog simulation in iverilog

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Directories and files for pop_quiz
POP_QUIZ_DIR = pop_quiz
POP_QUIZ_VERILOG_FILES = $(POP_QUIZ_DIR)/src/pop_quiz.sv $(POP_QUIZ_DIR)/test/pop_quiz_tb.sv
POP_QUIZ_TOP_MODULE = pop_quiz_tb
POP_QUIZ_OUTPUT_FILE = $(POP_QUIZ_DIR)/test/simulation.vvp
POP_QUIZ_VCD_FILE = $(POP_QUIZ_DIR)/test/pop_quiz.vcd

# Directories and files for 4bit_counter
COUNTER_DIR = 4bit_counter
COUNTER_VERILOG_FILES = $(COUNTER_DIR)/src/4bit_counter.sv $(COUNTER_DIR)/test/4bit_counter_tb.sv
COUNTER_TOP_MODULE = 4bit_counter_tb
COUNTER_OUTPUT_FILE = $(COUNTER_DIR)/simulation.vvp
COUNTER_VCD_FILE = $(COUNTER_DIR)/test/counter.vcd

# Default target
all: pop_quiz counter

# Compile and simulate pop_quiz
pop_quiz: compile_pop_quiz simulate_pop_quiz

compile_pop_quiz:
	$(IVERILOG) -g2012 -o $(POP_QUIZ_OUTPUT_FILE) $(POP_QUIZ_VERILOG_FILES)

simulate_pop_quiz:
	$(VVP) $(POP_QUIZ_OUTPUT_FILE)

view_pop_quiz:
	$(GTKWAVE) $(POP_QUIZ_VCD_FILE)

# Compile and simulate 4bit_counter
counter: compile_counter simulate_counter

compile_counter:
	$(IVERILOG) -g2012 -o $(COUNTER_OUTPUT_FILE) $(COUNTER_VERILOG_FILES)

simulate_counter:
	$(VVP) $(COUNTER_OUTPUT_FILE)

view_counter:
	$(GTKWAVE) $(COUNTER_VCD_FILE)

# Clean up generated files
clean:
	rm -f $(POP_QUIZ_OUTPUT_FILE) $(POP_QUIZ_VCD_FILE) $(COUNTER_OUTPUT_FILE) $(COUNTER_VCD_FILE)

.PHONY: all pop_quiz compile_pop_quiz simulate_pop_quiz view_pop_quiz counter compile_counter simulate_counter view_counter clean
