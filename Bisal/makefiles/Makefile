#  ============================================================================
#  Filename:    Makefile
#  Description: File consists of codes based on concepts of Makefile
#  Author:      Bisal Saeed
#  Date:        7/4/2024
#  ============================================================================

#NOTE: run using command : cd makefiles make

#NOTE: Use $ for make variable and $$ for shell variable within recipe
CC = gcc
#enables all warnings
CFLAGS = -Wall
DEBUGFLAGS = -g
# as target is exercise 2 so both obj files will be converted into one exercise 2 executable
TARGET= ../exercise2  
SRCS=$(wildcard ../*.c)
OBJS=$(SRCS:.c=.o)
#SCRIPTDIR=../scripts
SCRIPTSDIR=$(wildcard ../scripts/*.sh)
UNITTESTDIR=../tests

#This is the default target. When you type make without any arguments, it builds the
#TARGET specified (../exercise2 in this case).
all: $(TARGET) 

#LINKING
#$^ will automatically link all dependencies and $@ will convert all file into executables
#OBJS takes all the sc files in the folder and compile them 
$(TARGET) : $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

#COMPILATION
#THis command checks all object files for respective c files and match them,% for matching filenames
#$< only for first pre-req
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

#DEBUG TARGET : Rebuilts after cleaning at debug mode and add debug flag to flags
debug:CFLAGS += $(DEBUGFLAGS)
debug:clean all 

#DEPENDENCY TRACKING
#list all c files corresponding dependency files and include if any available already 
DEPTRAC= $(SRCS:.c=.d)
	-include $(DEPTRACK)
#convert all c files to dependency files,-MM flag for dependency files for Makefile usage
#-MF flag tells filename where dpenedency output will be stored 
%.d: %.c
	$(CC) $(CFLAGS) -MM -MF $@ $<

syntaxCheck:
	@echo "Checking for syntax errors ins cripts..... "
	@for file in $(SRCS);do \
		#syntax only check on files
		gcc -fsyntax-only $$file; \
		if [ $$? -ne 0 ]; then \
		     echo "Syntax check failed "; \
		     exit 1; \
		fi; \
	done
	@echo "Syntax check passed for all files..."

#UNITTESTS
unit-tests:
	@echo "Running unit tests on files...." 
	#execute make for all files in unittestdirectory ,-c to change directory to unittestdirectory
	@$(MAKE) -C $(UNITTESTDIR) 

#INSTALL
install:
	@echo "Installing scripts to $(SCRIPTSDIR)..." 
	#recursively copy all files and directories from scriptdirectory 
	@cp -r * $(SCRIPTSDIR)

#CLEAN 
clean:                                                                                                                          rm -f $(TARGET) 
#not actual files but commands to execute 
.PHONY: all clean debug

