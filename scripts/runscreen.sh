#!/bin/bash

prompt="Choose: (K) Konsole, (S) Show, (T) Start, (P) Stop, (R) Restart, (U) Status, (C) Clear, (X) Exit"
promptenter="Press Enter to continue."
promptcluster="Enter Cluster Number: "
directoryprefix="Cluster_"
promptdirectory="Directory does not exist: $directoryprefix"
promptinvalid="Invalid option: "
title="DST Server "
directoryserver=/home/steam/steamapps/DST/bin
directoryconfig=~/.klei/DoNotStarveTogether

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
        if [[ $mode -gt 0 ]]
        then
            echo "$promptcluster"
            read option
        else
            option=$1
            shift
        fi
        option=${option,,}
        
        if [[ "$option" != "" ]]
        then
            cd $directoryconfig
            if [[ -d "$directoryprefix$option" ]]
            then
                nohup konsole --new-tab -p tabtitle="$title$option" -e sudo screen -dr "$title$option" &>/dev/null &
                read -p "$promptenter"
            else
                echo "$promptdirectory$option"
            fi
        else
            echo "$promptinvalid$option"
        fi
        
    elif [[ $option = "show" || $option = "s" || $option -eq 2 ]]
    then
        if [[ $mode -gt 0 ]]
        then
            echo "$promptcluster"
            read option
        else
            option=$1
            shift
        fi
        option=${option,,}
        
        if [[ "$option" != "" ]]
        then
            cd $directoryconfig
            if [[ -d "$directoryprefix$option" ]]
            then
                screen -dr "$title$option"
            else
                echo "$promptdirectory$option"
            fi
        else
            echo "$promptinvalid$option"
        fi
        
    elif [[ $option = "start" || $option = "t" || $option -eq 3 ]]
    then
        if [[ $mode -gt 0 ]]
        then
            echo "$promptcluster"
            read option
        else
            option=$1
            shift
        fi
        option=${option,,}
        
        if [[ "$option" != "" ]]
        then
            cd $directoryconfig
            if [[ -d "$directoryprefix$option" ]]
            then
                cd $directoryserver
                nice -n -5 screen -dmS "$title$option" ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether -cluster $directoryprefix$option
            else
                echo "$promptdirectory$option"
            fi
        else
            echo "$promptinvalid$option"
        fi
        
    elif [[ $option = "stop" || $option = "p" || $option -eq 4 ]]
    then
        if [[ $mode -gt 0 ]]
        then
            echo "$promptcluster"
            read option
        else
            option=$1
            shift
        fi
        option=${option,,}
        
        if [[ "$option" != "" ]]
        then
            cd $directoryconfig
            if [[ -d "$directoryprefix$option" ]]
            then
                screen -XS "$title$option" quit
            else
                echo "$promptdirectory$option"
            fi
        else
            echo "$promptinvalid$option"
        fi
        
    elif [[ $option = "restart" || $option = "r" || $option -eq 5 ]]
    then
        if [[ $mode -gt 0 ]]
        then
            echo "$promptcluster"
            read option
        else
            option=$1
            shift
        fi
        option=${option,,}
        
        if [[ "$option" != "" ]]
        then
            cd $directoryconfig
            if [[ -d "$directoryprefix$option" ]]
            then
                ./runscreen.sh p $option t $option
            else
                echo "$promptdirectory$option"
            fi
        else
            echo "$promptinvalid$option"
        fi
        
    elif [[ $option = "status" || $option = "u" || $option -eq 6 ]]
    then
        if [[ $mode -gt 0 ]]
        then
            echo "$promptcluster"
            read option
        else
            option=$1
            shift
        fi
        option=${option,,}
        
        if [[ "$option" != "" ]]
        then
            cd $directoryconfig
            if [[ -d "$directoryprefix$option" ]]
            then
                screen -ls "$title$option"
            else
                echo "$promptdirectory$option"
            fi
        else
            screen -ls "$title"
        fi
        
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

#let "mode--"
