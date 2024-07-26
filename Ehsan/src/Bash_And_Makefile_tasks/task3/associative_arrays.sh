#!/bin/bash

#printing capitals of country with country name with associative array

country() {
    read -p "Enter country : " COUNTRY
    if [[ -v country_capitals[$COUNTRY] ]]; then
        echo "The capital of $COUNTRY is ${country_capitals[$COUNTRY]}"
    else
        echo "Country is not in list"
    fi
}

declare -A country_capitals

country_capitals["Pakistan"]="Islamabad"
country_capitals["India"]="New Delhi"
country_capitals["USA"]="Washington, D.C."
country_capitals["Japan"]="Tokyo"
country_capitals["UK"]="London"
country_capitals["France"]="Paris"

country
