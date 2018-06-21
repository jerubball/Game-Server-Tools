#!/bin/bash

prompt="Choose: (S) Screen, (K) Konsole, (U) Update, (C) Clear, (X) Exit"
promptenter="Press Enter to close."
promptinvalid="Invalid option: "

if [[ $# -gt 0 ]]
then
    mode=0
else
    mode=1
fi

while [[ $# -gt 0 || $mode -gt 0 ]]
do
    if [[ $mode -gt 0 ]]
    then
        echo "$prompt"
        read option
    else
        option=$1
        shift
    fi
    option=${option,,}
    
    if [[ $option = "screen" || $option = "s" || $option -eq 1 ]]
    then
        ./runscreen.sh $@
        shift $#
        
    elif [[ $option = "konsole" || $option = "k" || $option -eq 2 ]]
    then
        ./runkonsole.sh $@
        shift $#
        
    elif [[ $option = "update" || $option = "u" || $option -eq 3 ]]
    then
        ./update.sh
        
    elif [[ $option = "clear" || $option = "c" || $option -eq 4 ]]
    then
        clear
        
    elif [[ $option = "exit" || $option = "x" || $option -eq 5 ]]
    then
        shift $#
        mode=0
    else
        echo "$promptinvalid$option"
    fi
done

read -p "$promptenter"
