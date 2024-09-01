# _*_ Makefile _*_

CFLAGS = -Wall

all: main


main: *.o
	gcc $(CFLAGS) *.o -o main

%.o: %.c
	gcc $(CFLAGS) -c $^

.PHONY: clean all debug
clean: 
	rm *.o main

debug: CFLAGS = -Wall -g
debug: clean all
