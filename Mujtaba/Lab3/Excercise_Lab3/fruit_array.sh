#!/usr/bin/env bash
fruits(){
    fruit_array=('banana' 'apple' 'mango' 'stawberry' 'watermelon')
    for element in ${fruit_array[@]}
    do
        echo $element
    done
}
fruits
