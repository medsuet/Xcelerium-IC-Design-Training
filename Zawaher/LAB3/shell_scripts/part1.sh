#!/bin/bash

echo "Hello,World!"

read -p "Enter your name: " Name 

echo "Assalam-o-alaikum $Name"
 
read -p "Enter two inputs for addition: " input_1 input_2

echo "The sum of two arguments is:$(($input_1  + $input_2))"
