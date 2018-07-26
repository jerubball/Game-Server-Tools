#!/bin/bash

prompt="[Screen] Choose: (K) Konsole, (S) Show, (T) Start, (P) Stop, (R) Restart, (U) Status, (C) Clear, (X) Exit"
promptworld="World: (O) Overworld, (C) Caves"
promptenter="Press Enter to continue."
promptinvalid="Invalid option: "
title="DST EasyConfig"
overworld="$title:Overworld"
caves="$title:Caves"
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
        nohup konsole --new-tab -p tabtitle="Overworld" -e sudo screen -dr "$overworld" &>/dev/null &
        nohup konsole --new-tab -p tabtitle="Caves" -e sudo screen -dr "$caves" &>/dev/null &
        read -p "$promptenter"
        
    elif [[ $option -eq 2 ]]
    then
        if [[ $mode -gt 0 ]]
        then
            echo "$promptworld"
            read shard
        else
            shard=$1
            shift
        fi
        shard=${shard,,}
        
        if [[ $shard = "master" || $shard = "m" || $shard = "overworld" || $shard = "o" || $shard -eq 1 ]]
        then
            shard=$overworld
        elif [[ $shard = "caves" || $shard = "c" || $shard -eq 2 ]]
        then
            shard=$caves
        else
            shard=""
        fi
        
        if [[ "$shard" != "" ]]
        then
            screen -dr "$shard"
        fi
        
    elif [[ $option -eq 3 ]]
    then
        cd $directoryserver
        nice -n -10 screen -dmS "$overworld" ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether_EasyConfig -cluster Cluster_1 -shard Master
        nice -n -10 screen -dmS "$caves" ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether_EasyConfig -cluster Cluster_1 -shard Caves
        
    elif [[ $option -eq 4 ]]
    then
        screen -XS "$overworld" quit
        screen -XS "$caves" quit
        
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
        shift $#
        mode=0
    else
        echo "$promptinvalid$option"
    fi
done
