CC=gcc
CFLAGS= -Wall
DEBUG_CFLAG=-g
DEPS = $(wildcard *.h)
SRCS = $(wildcard *.c)
OBJ = $(patsubst %.c, %.o, $(SRCS))

all: $(OBJ)

debug: CFLAGS+=$(DEBUG_CFLAG)
debug: $(OBJ)

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<
	@echo "$<"

hello: $(OBJ)
	$(CC) -o $@ $^
	@echo "$^"

clean:
	rm -rf *.o hello
