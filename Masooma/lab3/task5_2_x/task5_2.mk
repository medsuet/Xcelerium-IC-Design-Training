CC=gcc
TARGET=execute
SRCS=main.c function.c
OBJ=$(SRCS:.c=.o)
all:${TARGET}
	@echo "Done!!"
${TARGET}:${OBJ}
	${CC} $^ -o $@
%.o:%.c
	${CC} -MMD -c $^ -o $@
debug:${OBJ}
	${CC} -g $^ -o ${TARGET}
clean:
	rm -f ${TARGET} ${OBJ} *.d
-include $(DEP) #ensuring that changes in header files trigger recompilation of dependent source files

