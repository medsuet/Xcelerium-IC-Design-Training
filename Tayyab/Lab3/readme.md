Bash shell scripts can be run as provided for tasks 1-4.

For task 5.1 and 5.2, use makefile1:
    `make -f makefile1 <target>`
Possible targets are:
main        :   executable from main.c and functions.c
main.o      :   object file from main.c
functions.o :   object file from functions.c
debug       :   compile main.c and functions.c with debug (-g) flag.

`make all` and `make clean` supported.

For task 5.3:
    `make -f makefile2 <target>`
Possible targets are:
syntax      :   runs syntax check on all .sh files in the directory.
test        :   runs predefined tests on selected bash scripts.
install     :   copies all .sh files to subdirectory installscripts (creates it if not preset)

```make all``` supported.