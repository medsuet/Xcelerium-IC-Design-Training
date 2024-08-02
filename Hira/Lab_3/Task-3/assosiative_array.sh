#!/bin/bash

declare -A assos_array

assos_array["pakistan"]="islamabad"
assos_array["korea"]="seoul"
assos_array["norway"]="oslo"
assos_array["france"]="paris"

enter_country(){
	echo "Enter the name of country"
	read country
	for key in "${!assos_array[@]}"; do
	       if [ $key == $country ]; then
			echo "The captical of $country is ${assos_array[$key]}"
		exit
	       fi	       
	done
	echo "Limited database"
}

enter_country

