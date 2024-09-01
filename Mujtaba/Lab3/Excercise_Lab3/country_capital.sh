#!/usr/bin/env bash
country_capitals(){
    declare -A country_capital
    country_capital['Pakistan']='Islamabad'
    country_capital['Germany']='Berlin'
    country_capital['India']='Mumbai'
    country_capital['Bangladesh']='Dhaka'
    country_capital['Afghanistan']='Kabul'
    country_capital['Turkey']='Istanbul'

    if [ -z ${country_capital[$1]} ]; then
        echo "The capital of '$1' doesn't exists."
    else
        echo "The capital of '$1' is ${country_capital[$1]}"
    fi
}

country_capitals $1
