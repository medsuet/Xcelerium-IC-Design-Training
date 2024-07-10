#!/bin/bash
all:execute
	@echo "Done!!!"
execute:main.o function.o
	gcc main.o function.o -o execute
main.o:main.c
	gcc -c main.c -o main.o
function.o:function.c
	gcc -c function.c -o function.o
clean:
	rm execute main.o function.o