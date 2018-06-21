#!/bin/bash

prompt="Choose: (K) Konsole, (S) Show, (T) Start, (P) Stop, (R) Restart, (U) Status, (C) Clear, (X) Exit"
promptworld="World: (O) Overworld, (C) Caves"
promptenter="Press Enter to continue."
promptinvalid="Invalid option: "
title="DST EasyConfig "
overworld="DST EasyConfig Overworld"
caves="DST EasyConfig Caves"
directoryserver=/home/steam/steamapps/DST/bin
directoryconfig=~/.klei/DoNotStarveTogether_EasyConfig

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
    
    if [[ $option = "konsole" || $option = "k" || $option -eq 1 ]]
    then
        nohup konsole --new-tab -p tabtitle="Overworld" -e sudo screen -dr "$overworld" &>/dev/null &
        nohup konsole --new-tab -p tabtitle="Caves" -e sudo screen -dr "$caves" &>/dev/null &
        read -p "$promptenter"
        
    elif [[ $option = "show" || $option = "s" || $option -eq 2 ]]
    then
        if [[ $mode -gt 0 ]]
        then
            echo "$promptworld"
            read option
        else
            option=$1
            shift
        fi
        option=${option,,}
        
        if [[ $option = "overworld" || $option = "o" || $option -eq 1 ]]
        then
            option=$overworld
        elif [[ $option = "caves" || $option = "c" || $option -eq 2 ]]
        then
            option=$caves
        else
            option=""
        fi
        
        if [[ "$option" != "" ]]
        then
            screen -dr "$option"
        fi
        
    elif [[ $option = "start" || $option = "t" || $option -eq 3 ]]
    then
        cd $directoryserver
        nice -n -10 screen -dmS "$overworld" ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether_EasyConfig -cluster Cluster_1
        nice -n -10 screen -dmS "$caves" ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether_EasyConfig -cluster Cluster_914469371
        
    elif [[ $option = "stop" || $option = "p" || $option -eq 4 ]]
    then
        screen -XS "$overworld" quit
        screen -XS "$caves" quit
        
    elif [[ $option = "restart" || $option = "r" || $option -eq 5 ]]
    then
        cd $directoryconfig
        ./runscreen.sh p t
        
    elif [[ $option = "status" || $option = "u" || $option -eq 6 ]]
    then
        screen -ls "$title"
    
    elif [[ $option = "clear" || $option = "c" || $option -eq 7 ]]
    then
        clear
        
    elif [[ $option = "exit" || $option = "x" || $option -eq 8 ]]
    then
        shift $#
        mode=0
    else
        echo "$promptinvalid$option"
    fi
done
