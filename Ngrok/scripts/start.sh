#!/bin/bash

args=$(getopt -q -s bash -l "help,restart,silent,nofallback" "?hrsn" "$@")
eval set -- "$args"

restart=1
nofallback=1
mode=start

while [[ $# > 0 ]]
do
    # option processing
    case $1 in
        -h | --help | -\? )
            echo "[--restart] [--silent] [--nofallback]"
            exit
        ;;
        -r | --restart )
            restart=0
        ;;
        -s | --silent )
            mode=silent
        ;;
        -n | --nofallback )
            fallback=0
        ;;
        -- )
            shift
            break
        * )
            echo "unrecognized option"
            exit 1
        ;;
    esac
    shift
done

cd /home/ieee/.ngrok2

if [[ restart -eq 0 ]]
then
    ./easyscreen.sh stop ngrok
fi

tunnels=$(cat tunnels)

if [[ "$tunnels" != "" ]]
then
    ./easyscreen.sh $mode ngrok ./ngrok start $tunnels
fi

if [[ nofallback -eq 0 && "$(screen -ls "$name" | grep "$name")" == "" ]]
then
    ./easyscreen.sh $mode ngrok ./ngrok start ssh
    
    if [[ "$(screen -ls "$name" | grep "$name")" == "" ]]
    then
        ./easyscreen.sh $mode ngrok ./ngrok tcp 22
    fi
fi
