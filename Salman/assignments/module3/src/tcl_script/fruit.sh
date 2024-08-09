#!/bin/bash

function printfruits {
   arr=( $@ ) # ( ) brackets to ensure that @ elemts form an array
   for i in ${arr[@]}; # @ to represent all elements of array
      do
          echo $i
      done
}

fruits=("apple" "orange" "banana" "cherry" "date" "peach")
printfruits ${fruits[@]}

echo "Adding new element"

fruits+=("mango") # appends at end of array
printfruits ${fruits[@]}
