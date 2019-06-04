#!/bin/bash

promptcluster="Enter Cluster Number: "
promptshard="Enter Shard Name: "
promptenter="Press Enter to continue."
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
        shift $#
        mode=0
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
            cd $directoryserver
            
            nohup konsole --new-tab -p tabtitle="$title$cluster:$shard" -e nice -n -5 ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether -cluster $directoryprefix$cluster -shard $shard &>/dev/null &
            read -p "$promptenter"
        else
            echo "$promptdirectory$shard"
        fi
        shard=""
    else
        echo "$promptdirectory$directoryprefix$cluster"
    fi
    cluster=""
done

# for i in $(seq $count)
