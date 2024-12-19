#part 5.1

#all:main functions
    
#main:main.c
#	gcc -o main main.c
#fnctions:functons.c
#	gcc -o functions functions.c	
#clear:  
#	rm -r main
#	rm -r functions

#part 5.2

CC = gcc
CFLAGS = -I -Wall -MMD -MP

SRC = src/XL1.c
OBJ = $(SRC:.c=.o)
DEP = $(OBJ:.o=.d)	
Target = myprogram

all:$(myprogram)

$(myprogram):$(OBJ)
	$(CC) -o $@ $^

%.o: %.c 
	$(CC) $(CFLAGS) -c $< -o $@

-include $(DEP)
clean:
	rm -f $(OBJ) $(Target) $(DEP)
debug: CFLAGS += -g
debug: all


#part 5.3
run:
	./XL2 
	

#scripts_DIR = Lab3


#SCRIPTS  = $(wildcard $(*.sh))


#all:check

#check:
#	@echo "checkingsyntax error"
#	@for script in $(SCRIPTS);do\
#		bash -n $$script || exit 1;\
#	done
#	@echo "no suntax error"	

