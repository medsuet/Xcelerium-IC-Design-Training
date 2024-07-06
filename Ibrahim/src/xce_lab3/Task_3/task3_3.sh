#!/bin/bash

# Enbale associative arrays
declare -A country_capitals

# create an associatve array of country_capital pairs
country_capitals=(
	["USA"]="Washington, DC"
	["Canada"]="Ottawa"
	["Germany"]="Berlin"
	["Pakistan"]="Islamabad"
	["France"]="Paris"
	["Japan"]="Tokyo"
)
# FUnction to get a capital
get_capital() {
	local country=$1

	# check if the country is in the array
	if [[ -n ${country_capitals[$country]} ]]; then
		echo "The capital of $country is ${country_capitals[$country]}."
	else
		echo "Error! Capital for $country not found."
	fi
}
read -p "Enter the name of a country: " country
get_capital "$country"
