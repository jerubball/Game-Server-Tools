#!/bin/bash

prompt="Choose: (K) Konsole, (S) Screen, (H) Here, (C) Clear, (X) Exit"
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
    
    if [[ $option -eq 0 ]]
    then
        if [[ $option = "k" || $option = "konsole" ]]
        then
            option=1
        elif [[ $option = "s" || $option = "screen" ]]
        then
            option=2
        elif [[ $option = "h" || $option = "here" ]]
        then
            option=3
        elif [[ $option = "c" || $option = "clear" ]]
        then
            option=4
        elif [[ $option = "x" || $option = "exit" ]]
        then
            option=5
        fi
    fi
    
    if [[ $option -eq 1 ]]
    then
        ./runkonsole.sh $@
        shift $#
        mode=0
        
    elif [[ $option -eq 2 ]]
    then
        ./runscreen.sh $@
        shift $#
        mode=0
        
    elif [[ $option -eq 3 ]]
    then
        ./runtshock.sh $@
        shift $#
        mode=0
        
    elif [[ $option -eq 4 ]]
    then
        clear
        
    elif [[ $option -eq 5 ]]
    then
        mode=0
    else
        echo "$promptinvalid$option"
    fi
done

read -p "$promptenter"
