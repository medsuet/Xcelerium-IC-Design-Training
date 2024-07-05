#!/bin/bash

function printArray ()
{
	local -n array_ref=$1
	read -p "Enter a Country:" country
	if [ -z (${array_ref[$country]} ]; then
		echo "The country is not in the array"
	else
		echo "The Capital of $country is ${array_ref[$country]}"
}


declare -A array=(["Pakistan"]="Islamabad" ["India"]="Delhi" ["China"]="Beijing" ["Turkey"]="Ankara" ["Bangladesh"]="Dhaka" ["Canada"]="Torronto")

printArray array