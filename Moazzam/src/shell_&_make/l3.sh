#!/bin/bash

function fac(){
    if [ $1 -eq 1 ]; then
        echo 1
    else 
        sec=$(fac $(( $1 - 1)))
        echo $(( $1 * sec))
    fi
}

fac 5


function fruitfunc(){
    arr=( $@ )
    for x in ${arr[@]};
    do
        echo "$x"
    done
}

fruit=("apple" "mango" "date")
fruitfunc ${fruit[@]}

echo "  "

fruit+=("cherry")
fruitfunc ${fruit[@]}

echo " "

function guesscap(){

    echo "enter name of country"
    read con
    
    declare -A example_array=(["pakistan"]="islamabad" ["turkey"]="ankra" ["china"]="beijing" ["india"]="delhi" ["germany"]="berlin")

    for key in ${!example_array[@]}
    do
        if [ "$key" == "$con" ]; then
            echo "the capital of ${key} is ${example_array[${key}]}"    
            return 
        fi
    done
    echo "sorry i don't know capital of ${con}"
}

guesscap
