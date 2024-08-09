# Variables
PYTHON := python3

# Default target
all: help

# Help manual
help:
	@echo "Usage:"
	@echo "  make run FILE=<filename>   Run the specified Python script"
	@echo "  make clean                Clean up any generated files"
	@echo "  make help                 Show this help manual"

# Run the specified Python script
run:
	@if [ -z "$(FILE)" ]; then \
		echo "Error: No file specified. Use 'make run FILE=<filename.py>' to run a Python script."; \
		exit 1; \
	fi
	$(PYTHON) $(FILE)

# Clean up any generated files (if applicable)
clean:
	rm -f *.pyc
	rm -rf __pycache__

# Phony targets to avoid conflicts with files named 'all', 'run', 'clean', or 'help'
.PHONY: all run clean help
