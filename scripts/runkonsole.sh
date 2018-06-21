#!/bin/bash

prompt="Enter Cluster Number, or Enter 0 or X to Exit"
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
        
    if [[ $option = "exit" || $option = "x" || $option -eq 0 ]]
    then
        shift $#
        mode=0
    elif [[ "$option" != "" ]]
    then
        cd $directoryconfig
        if [[ -d "$directoryprefix$option" ]]
        then
            cd $directoryserver
            nohup konsole --new-tab -p tabtitle="$title$option" -e nice -n -5 ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether -cluster $directoryprefix$option &>/dev/null &
            read -p "$promptenter"
        else
            echo "$promptdirectory$option"
        fi
    else
        echo "$promptinvalid$option"
    fi
done

# for i in $(seq $count)
