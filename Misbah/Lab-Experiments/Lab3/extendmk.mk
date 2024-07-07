CC=gcc
TARGET=execute
SRCS=main.c functions.c
OBJ=$(SRCS:.c=.o)
all:${TARGET}
	@echo "Done extending!"
${TARGET}:${OBJ}
	${CC} -MMD -c $^ -o $@
debug:${OBJ}
	${CC} -g $^ -o ${TARGET}
clean:
	rm -f ${TARGET} ${OBJ} *.d
-include $(DEP)
