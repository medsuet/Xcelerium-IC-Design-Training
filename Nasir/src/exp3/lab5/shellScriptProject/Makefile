# Variables
SCRIPTS = script1.sh script2.sh
TESTS = testScript1.sh testScript2.sh
INSTALL_DIR = /usr/local/bin

# Targets
all: check

check: $(SCRIPTS)
	@echo "Checking syntax..."
	@for script in $(SCRIPTS); do \
		bash -n $$script || exit 1; \
	done
	@echo "Syntax check passed."

test: $(SCRIPTS) $(TESTS)
	@echo "Setting execute permissions..."
	@chmod +x $(SCRIPTS) $(TESTS)
	@echo "Running unit tests..."
	@for test in $(TESTS); do \
		bash $$test || exit 1; \
	done
	@echo "All tests passed."

install: $(SCRIPTS)
	@echo "Setting execute permissions..."
	@chmod +x $(SCRIPTS)
	@echo "Installing scripts to $(INSTALL_DIR)..."
	@for script in $(SCRIPTS); do \
		install -m 755 $$script $(INSTALL_DIR); \
	done
	@echo "Scripts installed to $(INSTALL_DIR)."

clean:
	@echo "Cleaning up..."
	@rm -f *.log
	@echo "Clean up done."

.PHONY: all check test install clean
