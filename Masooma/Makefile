FIRSTTARGET=lab1_exe
SECTARGET=lab2_exe
THIRDTARGET=booth_exe
FOURTHTARGET=maze_exe
.PHONY: lab3 lab5
$(FIRSTTARGET):lab1_x.c
	gcc -o $@ $^
$(SECTARGET):lab2_x.c
	gcc -o $@ $^
$(THIRDTARGET):booth.c
	gcc -o $@ $^
$(FOURTHTARGET):maze.c
	gcc -o $@ $^
lab1:$(FIRSTTARGET)
	./$(FIRSTTARGET)
	@echo "--------------------------------------"
	@echo "Done LAB1!!"
	@echo "--------------------------------------"
lab2:$(SECTARGET)
	./$(SECTARGET)
	@echo "--------------------------------------"
	@echo "Done LAB2!!"
	@echo "--------------------------------------"
booth:$(THIRDTARGET)
	./$(THIRDTARGET)
	@echo "--------------------------------------"
	@echo "Done BOOTH MULTIPLICATION!!"
	@echo "--------------------------------------"
lab3:
	@echo "--------------------------------------"
	@echo "Task 1.1"
	@echo "--------------------------------------"
	@echo "Print Hello, World"
	@echo "--------------------------------------"
	@sudo chmod +x -R ./lab3
	./lab3/hello.sh
	@echo "--------------------------------------"
	@echo "Task 1.2"
	@echo "--------------------------------------"
	@echo "Greeting using the stored name"
	@echo "--------------------------------------"
	./lab3/myName.sh
	@echo "--------------------------------------"
	@echo "Task 1.3"
	@echo "--------------------------------------"
	@echo "Sum of two numbers"
	@echo "--------------------------------------"
	./lab3/sum.sh 7 4
	@echo "--------------------------------------"
	@echo "Task 2.1"
	@echo "--------------------------------------"
	@echo "Even Odd"
	@echo "--------------------------------------"
	./lab3/evenodd.sh 7
	./lab3/evenodd.sh 44
	@echo "--------------------------------------"
	@echo "Task 2.2"
	@echo "--------------------------------------"
	@echo "First 10 multiples of a number"
	@echo "--------------------------------------"
	./lab3/multiples.sh 13
	@echo "--------------------------------------"
	@echo "Task 2.3"
	@echo "--------------------------------------"
	@echo "Guessing game"
	@echo "--------------------------------------"
	./lab3/game.sh
	@echo "--------------------------------------"
	@echo "Task 3.1"
	@echo "--------------------------------------"
	@echo "Prints each fruit in the array"
	@echo "--------------------------------------"
	./lab3/array.sh
	@echo "--------------------------------------"
	@echo "Task 3.2"
	@echo "--------------------------------------"
	@echo "Associative array of country-capital pairs"
	@echo "--------------------------------------"
	./lab3/asso_arr.sh
	@echo "--------------------------------------"
	@echo "Task 4.1"
	@echo "--------------------------------------"
	@echo " File Reading"
	@echo "--------------------------------------"
	./lab3/read.sh
	@echo "--------------------------------------"
	@echo "Task 4.2"
	@echo "--------------------------------------"
	@echo " Log File Processing"
	@echo "--------------------------------------"
	./lab3/actions.sh
	@echo "--------------------------------------"
	@echo "Task 4.3"
	@echo "--------------------------------------"
	@echo " File Backup"
	@echo "--------------------------------------"
	./lab3/backup.sh
	@echo "--------------------------------------"
lab5:
	@echo "--------------Task 1--------------"
	tclsh ./lab5/digital_calc.tcl
	@echo "\n--------------Task 2--------------\n"
	tclsh ./lab5/design_data.tcl
	@echo "--------------------------------------"
	@echo "Done LAB 5!!"
	@echo "--------------------------------------"
maze: $(FOURTHTARGET)
	./maze_exe
	@echo "--------------------------------------"
	@echo "Done MAZE!!"
	@echo "--------------------------------------"




	





