# Shell Scripting and Makefiles

This folder contains a set of shell script exercises aimed to learn the basic concepts.

## Part 1: Basic Shell Scripting
Opens the `Excercise_Lab1` of this repository that contains files for the `Part 1`.

- **File:** `hello.sh`
- **Description:** Hello World! Example of the shell script language.

- **File:** `greeting.sh`
- **Description:** Take the name of the user and return greeting message to the user.

- **File:** `sum_nums.sh`
- **Description:** Take two arguments and returns the sum of those arguments.

## Part 2: Control Structures
Open the `Excercise_Lab2` of this repository that contains files for the `Part 2`.

- **File:** `even_odd_check.sh`
- **Description:** File take only one argument and tell that argument is even or odd.

- **File:** `guess_game.sh`
- **Description:** Guessing Game that only quit when you right guess entered.

- **File:** `num_multiples.sh`
- **Description:** File take one argument and give you the 10 multiples of that argument.

## Part 3: Functions and Arrays
Open the `Excercise_Lab3` of this repository that contains files for the `Part 3`.

- **File:** `factorial.sh`
- **Description:** File take one argument and returns the factorial of that argument.

- **File:** `fruit_array.sh`
- **Description:** Print the all fruits stored in the array.

- **File:** `country_capital.sh`
- **Description:** Take the country name as an argument and return its capital that is stored in the associative array and if country name is not entered in the list then return the message indicating that the particular country capital is not exists.

## Part 4: Files Processing and Text Proccessing
Open the `Excercise_Lab4` of this repository that contains files for the `Part 4`.

- **File:** `file_read.sh`
- **Description:** Read file line by line. You have to change the variable `input_file` in that file accordingly.

- **File:** `process_logfile.sh`
- **Description:** Take one argument as the logfile and returns the total entries in the file made. Also tells the unique usernames and counts their actions with unique usernames.

- **File:** `backup_file.sh`
- **Description:** Back up the directory in the tar format. The file takes the path of directory as an argument.

## Part 5: Introduction to the Makefile
Open the `Excercise_Lab5` of this repository that contains files for the `Part 5`.

- **Folder:** `Basic_Makefile`
- **Description:** Folder having basic C files and then writes the Simple and Basic Makefile.

- **Folder:** `Advanced_Makefile`
- **Description:** Folder having the C files and then writes the Advanced Version of Makefile compared to the previous task.

- **Folder:** `Shell_Script_Makefile`
- **Description:** Write the Makefile that checks the syntax errors in the shell script files.

# Run the script
In `Excercise_Lab1` `Excercise_Lab2` `Excercise_Lab3` `Excercise_Lab4`:
- **To run the scripts:** `./<file_name> <Arguments>` or `bash <file_name> <Arguments>`
In `Excercise_Lab5`, go to the individual directory:
- **To make all the builds files:** `make`
- **To clean all the builds:** `make clean`
