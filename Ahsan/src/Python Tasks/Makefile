# Variables
PYTHON = python3
SRC_DIR = src

# Default target
all: help

# Run a specific Python script
run:
	@$(PYTHON) $(SRC_DIR)/$(SCRIPT)

# Clean up temporary files
clean:
	@rm -f $(SRC_DIR)/*.pyc $(SRC_DIR)/__pycache__/*

# Help target to provide user with usage information
help:
	@echo "Usage:"
	@echo "  make run SCRIPT=<script_name.py>    - Run the specified Python script"
	@echo "  make clean                         - Clean up temporary files"

.PHONY: all run clean help

