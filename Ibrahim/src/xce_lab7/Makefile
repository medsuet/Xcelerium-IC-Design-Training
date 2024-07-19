# Makefile for running Python scripts

# Define the Python interpreter
PYTHON = python3

# Define the Python files
PROBLEM1 = problem1.py
PROBLEM2 = problem2.py
CACHE_SIMULATOR = cacheSimulator.py

# Default target
all: run_problem1 run_problem2 run_cache_simulator

# Target to run problem1.py
run_problem1:
	@echo "Running problem1.py..."
	$(PYTHON) $(PROBLEM1)

# Target to run problem2.py
run_problem2:
	@echo "Running problem2.py..."
	$(PYTHON) $(PROBLEM2)

# Target to run cacheSimulator.py
run_cache_simulator:
	@echo "Running cacheSimulator.py..."
	$(PYTHON) $(CACHE_SIMULATOR)

# Clean target (optional, if you have any temporary files to remove)
clean:
	@echo "Cleaning up..."
	rm -f *.pyc __pycache__/*

.PHONY: all run_problem1 run_problem2 run_cache_simulator clean
