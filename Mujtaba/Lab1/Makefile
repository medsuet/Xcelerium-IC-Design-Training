# _*_ Makefile _*_

all: template_code_Part0

template_code_Part0: template_code_Part0.o
	@gcc template_code_Part0.o -o template_code_Part0

template_code_Part0.o: template_code_Part0.c
	@gcc -c template_code_Part0.c

.PHONY: all clean run

clean: 
	@rm *.o template_code_Part0

run:
	@./template_code_Part0
