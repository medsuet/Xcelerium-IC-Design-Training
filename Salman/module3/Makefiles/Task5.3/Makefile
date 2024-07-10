# Shell scripts
SCRIPTS = script1.sh script2.sh

# Installation directory
INSTALL_DIR = ./test

# Default target
all: check test install

# Check scripts for syntax errors
# bash -n to check for syntax errors
check:
	for script in $(SCRIPTS); do \
	    echo "Checking $$script for syntax errors..."; \
	    bash -n $$script || exit 1; \
	done

# Run unit tests
test: check
	echo "Running unit tests..."
	bash test_script.sh

# Install scripts to the specified directory
# permission: 755 = r+w+x, -m sets permissions
install: check
	echo "Installing scripts to $(INSTALL_DIR)..."
	for script in $(SCRIPTS); do \
	    install -m 755 $$script $(INSTALL_DIR) || exit 1; \
	done
	echo "Succesfully installed scripts"

# Clean up
clean:
	echo "Cleaning up..."
	rm -f *.bak *.tmp