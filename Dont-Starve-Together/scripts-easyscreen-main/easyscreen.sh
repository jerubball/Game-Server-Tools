#!/bin/bash

version="
him-easyscreen version 1.3
    screen utility helper from him-nyit.ddns.net
"
help="
Usage: ./easyscreen.sh [OPTIONS] [COMMAND NAME PROGRAM]

OPTIONS:
    -h --help
        : bring this help topic
    -v --version
        : display script version
    -s --sudo
        : run with elevated priviledge
    
    s show
        : show screen session to terminal
          use [Ctrl] + [A], [D] to detach from screen session
    t start
        : start and show screen session
          Program must be provided.
    l silent
        : start screen session in background
          Program must be provided.
    p stop
        : terminate screen session
    r restart
        : terminate and silent start screen session
          Program must be provided.
    u status
        : show screen session status
    c clear
        : clear terminal
    x exit
        : exit interactive mode
"

prompt="Choose: (S) Show, (T) Start, (L) Silent, (P) Stop, (R) Restart, (U) Status, (C) Clear, (X) Exit"
promptenter="Press Enter to continue."
promptname="Set screen name."
promptapp="Enter command."
promptprefix="Enter prefix command."
promptnoapp="No program specified."
promptrunning="Program already running."
promptinvalid="Invalid option: "

manual=0
manualprefix=""
manualname=""
manualapp=""

if [[ $# -gt 0 ]]
then
    cont=0
    # print help topic
    if [[ $1 == "--help" || $1 == "-h" ]]
    then
        echo "$version"
        echo "$help"
        exit
        
    # print script version
    elif [[ $1 == "--version" || $1 == "-v" ]]
    then
        echo "$version"
        exit
    # run as sudo
    elif [[ $1 == "--sudo" || $1 == "-s" ]]
    then
        if [[ $(id -u) -ne 0 ]]
        then
            shift
            sudo ./$0 $@
            shift $#
            exit
        fi
    fi
else
    cont=1
fi

while [[ $# -gt 0 || $cont -gt 0 ]]
do
    if [[ $cont -gt 0 ]]
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
        if [[ $option = "s" || $option = "show" ]]
        then
            option=1
        elif [[ $option = "t" || $option = "start" ]]
        then
            option=2
        elif [[ $option = "l" || $option = "silent" ]]
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
    
    if [[ $option -gt 0 && $option -lt 7 ]]
    then
        if [[ $manual -eq 1 ]]
        then
            name="$manualname"
            app="$manualapp"
            prefix="$manualprefix"
        elif [[ $cont -gt 0 ]]
        then
            echo "$promptname"
            read name
            if [[ $option == 2 || $option == 3 || $option == 5 ]]
            then
                echo "$promptapp"
                read app
                echo "$promptprefix"
                read prefix
            fi
        else
            name=$1
            shift
            if [[ $# -eq 0 && ( $option == 2 || $option == 3 || $option == 5 ) ]]
            then
                echo "$promptnoapp"
            fi
            app=$*
            shift $#
            prefix=""
        fi
        
        if [[ $option -eq 1 ]]
        then
            # show
            screen -dr "$name"
        elif [[ $option -eq 2 ]]
        then
            # start
            if [[ "$(screen -ls "$name" | grep "$name")" == "" ]]
            then
                $prefix screen -mS "$name" $app
            else
                echo "$promptrunning"
            fi
        elif [[ $option -eq 3 ]]
        then
            # silent
            if [[ "$(screen -ls "$name" | grep "$name")" == "" ]]
            then
                $prefix screen -dmS "$name" $app
            else
                echo "$promptrunning"
            fi
        elif [[ $option -eq 4 ]]
        then
            # stop
            screen -XS "$name" quit
        elif [[ $option -eq 5 ]]
        then
            # restart
            screen -XS "$name" quit
            $prefix screen -dmS "$name" $app
        elif [[ $option -eq 6 ]]
        then
            # status
            screen -ls "$name"
        fi
    elif [[ $option -eq 7 ]]
    then
        clear
        
    elif [[ $option -eq 8 ]]
    then
        shift $#
        cont=0
    else
        echo "$promptinvalid$option"
    fi
    
done
