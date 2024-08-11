#!/bin/bash
declare -A country_capitals=( [US]="Washington DC" [PAKISTAN]="Bhowana" [FRANCE]="Peris" )
CAPITALS(){
	echo "Enter country name:"
	read country
	capital=${country_capitals[$country]}
	if [ -z "$capital" ];then
		echo "Capital of $country is not found."
	else
		echo "Capital of $country is $capital."
	fi
}
CAPITALS
	


