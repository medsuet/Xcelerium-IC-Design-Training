#!/bin/bash

function printfruits {
   arr=( $@ )
   for i in ${arr[@]};
      do
          echo $i
      done

}

fruits=("apple" "orange" "banana" "cherry" "date" "peach")
printfruits ${fruits[@]}

echo "Adding new element"

fruits+=("mango")
printfruits ${fruits[@]}
