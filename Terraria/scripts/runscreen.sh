#!/bin/bash

prompt="Choose: (K) Konsole, (S) Show, (T) Start, (P) Stop, (R) Restart, (U) Status, (C) Clear, (X) Exit"
promptenter="Press Enter to continue."
promptinvalid="Invalid option: "
title="Terraria Tshock Server"
directoryserver=~/.terraria/tshock_4.3.25
directoryconfig=~/.terraria

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
        elif [[ $option = "s" || $option = "show" ]]
        then
            option=2
        elif [[ $option = "t" || $option = "start" ]]
        then
            option=3
        elif [[ $option = "p" || $option = "stop" ]]
        then
            option=4
        elif [[ $option = "r" || $option = "restart" ]]
        then
            option=5
        elif [[ $option = "u" || $option = "status" ]]
        then
            option=6
        elif [[ $option = "c" || $option = "clear" ]]
        then
            option=7
        elif [[ $option = "x" || $option = "exit" ]]
        then
            option=8
        fi
    fi
    
    if [[ $option -eq 1 ]]
    then
        nohup konsole --new-tab -p tabtitle="Tshock" -e sudo screen -dr "$title" &>/dev/null &
        read -p "$promptenter"
        
    elif [[ $option -eq 2 ]]
    then
        screen -dr "$title"
        
    elif [[ $option -eq 3 ]]
    then
        cd $directoryserver
        nice -n -5 screen -dmS "$title" ./TerrariaServer.exe
        
    elif [[ $option -eq 4 ]]
    then
        screen -XS "$title" quit
        
    elif [[ $option -eq 5 ]]
    then
        cd $directoryconfig
        ./runscreen.sh p t
        
    elif [[ $option -eq 6 ]]
    then
        screen -ls "$title"
    
    elif [[ $option -eq 7 ]]
    then
        clear
        
    elif [[ $option -eq 8 ]]
    then
        mode=0
    else
        echo "$promptinvalid$option"
    fi
done
