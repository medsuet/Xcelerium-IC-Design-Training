#!/bin/bash
#declaring associative array
declare -A capitals

#now initializing the array
capitals["usa"]="Washington"
capitals["france"]="paris"
capitals["switzerlnad"]="genava"
capitals["pakistan"]="islamabad"
capitals["bangladesh"]="dhaka"

#function for asking country

get_capital(){
    echo "type name of country"
    read country
    if [[ -n "${capitals[$country]}" ]]; then
	    echo "the capital of $country is ${capitals[$country]}"
    else
	    echo "invalid"
   fi

}
get_capital
