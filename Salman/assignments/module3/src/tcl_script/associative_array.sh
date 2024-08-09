#!/bin/bash
#printing array by reference
function printArray ()
{
	local -n array_ref=$1 # creating copy of array, -n for reference pointer
	read -p "Enter a Country:" country
	if [ -z (${array_ref[$country]} ]; then # -z is used to compare
		echo "The country is not in the array"
	else
		echo "The Capital of $country is ${array_ref[$country]}"
}

# declaring array, -A to declare associative arrays
declare -A array=(["Pakistan"]="Islamabad" ["India"]="Delhi" ["China"]="Beijing" ["Turkey"]="Ankara" ["Bangladesh"]="Dhaka" ["Canada"]="Torronto")

printArray array