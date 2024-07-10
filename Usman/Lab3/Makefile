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

SRC = src/XL3Part1.sh src/XL3Part2.sh src/XL3Part3.sh src/XL3Part4.sh
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
	./XL3Part1.sh 2 3 
#	./XL3Part2.sh  :5
	./XL3Part3.sh 5
	./XL3Part4.sh myfile.sh

#scripts_DIR = Lab3


#SCRIPTS  = $(wildcard $(*.sh))


#all:check

#check:
#	@echo "checkingsyntax error"
#	@for script in $(SCRIPTS);do\
#		bash -n $$script || exit 1;\
#	done
#	@echo "no suntax error"	

