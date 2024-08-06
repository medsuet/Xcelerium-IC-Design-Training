#!/bin/bash
# Asks the user for a country and returns its capital using associative arrays
function getCapital() {
    read -p "Enter name of country: " country
    echo ${capitals[$country]}

    # Error handling
    # $? will store the return status of last command
    # return status 1 signifies error
    if [[ $?==1 ]]
    then
        echo "Country not found"
    fi
}

declare -A capitals
capitals[Britain]=London
capitals[China]=Bejing
capitals[Pakistan]=Islamabad
capitals[France]=Paris
capitals[Turkey]=Ankra
getCapital
