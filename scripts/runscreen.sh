#!/bin/bash

prompt="[Screen] Choose: (K) Konsole, (S) Show, (T) Start, (P) Stop, (R) Restart, (U) Status, (C) Clear, (X) Exit"
promptenter="Press Enter to continue."
promptcluster="Enter Cluster Number: "
promptshard="Enter Shard Name: "
directoryprefix="Cluster_"
promptdirectory="Directory does not exist: "
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
    
    if [[ $option -gt 0 && $option -lt 6 ]]
    then
        if [[ $mode -gt 0 ]]
        then
            echo "$promptcluster"
            read cluster
        else
            cluster=$1
            shift
        fi
        cluster=${cluster,,}
        
        cd $directoryconfig
        if [[ "$cluster" == "" ]]
        then
            echo "$promptinvalid$cluster"
            
        elif [[ -d "$directoryprefix$cluster" ]]
        then
            if [[ $mode -gt 0 ]]
            then
                echo "$promptshard"
                read shard
            else
                shard=$1
                shift
            fi
            shard=${shard,,}
            shard=${shard^}
            
            cd $directoryprefix$cluster
            if [[ "$shard" == "" ]]
            then
                echo "$promptinvalid$shard"
                
            elif [[ -d "$shard" ]]
            then
                if [[ $option -eq 1 ]]
                then
                    nohup konsole --new-tab -p tabtitle="$title$cluster:$shard" -e sudo screen -dr "$title$cluster:$shard" &>/dev/null &
                    read -p "$promptenter"
                elif [[ $option -eq 2 ]]
                then
                    screen -dr "$title$cluster:$shard"
                elif [[ $option -eq 3 ]]
                then
                    cd $directoryserver
                    nice -n -5 screen -dmS "$title$cluster:$shard" ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether -cluster $directoryprefix$cluster -shard $shard
                elif [[ $option -eq 4 ]]
                then
                    screen -XS "$title$cluster:$shard" quit
                elif [[ $option -eq 5 ]]
                then
                    cd $directoryconfig
                    ./runscreen.sh p $cluster $shard t $cluster $shard
                fi
            else
                echo $promptdirectory$shard
            fi
            shard=""
        else
            echo "$promptdirectory$directoryprefix$cluster"
        fi
        cluster=""
        
    elif [[ $option -eq 6 ]]
    then
        if [[ $mode -gt 0 ]]
        then
            echo "$promptcluster"
            read cluster
        else
            cluster=$1
            shift
        fi
        cluster=${cluster,,}
        
        cd $directoryconfig
        if [[ "$cluster" == "" ]]
        then
            screen -ls "$title"
            
        elif [[ -d "$directoryprefix$cluster" ]]
        then
            if [[ $mode -gt 0 ]]
            then
                echo "$promptshard"
                read shard
            else
                shard=$1
                shift
            fi
            shard=${shard,,}
            shard=${shard^}
            
            cd $directoryprefix$cluster
            if [[ "$shard" == "" ]]
            then
                screen -ls "$title$cluster:"
                
            elif [[ -d "$shard" ]]
            then
                screen -ls "$title$cluster:$shard"
            else
                echo $promptdirectory$shard
            fi
            shard=""
        else
            echo "$promptdirectory$directoryprefix$cluster"
        fi
        cluster=""
        
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

#let "mode--"
