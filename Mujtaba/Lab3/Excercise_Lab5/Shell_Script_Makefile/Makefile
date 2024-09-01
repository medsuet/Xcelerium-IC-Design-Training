# _*_ Makefile _*_

all: check

check:
	@echo Checking Syntax Error.....:
	@for script in $(wildcard *.sh); \
		do \
			bash -n $$script; \
			if [ "$$?" -ne 0 ]; then \
				echo "Syntax Eror in '$$script'"; \
				exit 1; \
			fi; \
		done
	@echo "All scripts passed the syntax error test."

.PHONY: check all
