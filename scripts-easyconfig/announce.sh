#!/bin/bash
# Original Script by noodlebox
# https://github.com/noodlebox/stream-announcer

set -e

prompt="[Announce] Choose: (T) Start, (P) Stop, (R) Restart, (U) Status, (X) Exit"
promptenter="Press Enter to continue."
promptinvalid="Invalid option: "
#color = (r << 16) + (g << 8) + b
#id='WEBHOOK_ID'
#token='WEBHOOK_TOKEN'
url="https://discordapp.com/api/webhooks/$id/$token"
#url=""
servername="Don't Starve Together Dedicated Server"
msgstart="$servername started."
msgstop="$servername stopped."
msgrestart="$servername is restarting."
msgrunning="$servername is currently running."
msgnotrunning="$servername is currently not running."
msgappend=$'\n  Server time: '
username='Server Status'

webhook_post() {
	curl --header 'Content-Type: application/json' --data-raw "$(</dev/fd/0)" "$1"
}

webhook_encode() {
	jq -c -n --arg content "$1" --arg username "$2" --argjson embeds "$(</dev/fd/0)" '{$content, $username, $embeds}'
}

announce_message() {
	webhook_encode "$1$msgappend$(date)" "$username" <<<'[]' | webhook_post "$url"
}

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
        if [[ $option = "t" || $option = "start" ]]
        then
            option=1
        elif [[ $option = "p" || $option = "stop" ]]
        then
            option=2
        elif [[ $option = "r" || $option = "restart" ]]
        then
            option=3
        elif [[ $option = "u" || $option = "status" ]]
        then
            option=4
        elif [[ $option = "x" || $option = "exit" ]]
        then
            option=5
        fi
    fi
    
    if [[ $option -eq 1 ]]
    then
        announce_message "$msgstart"
        
    elif [[ $option -eq 2 ]]
    then
        announce_message "$msgstop"
    
    elif [[ $option -eq 3 ]]
    then
        announce_message "$msgrestart"
        
    elif [[ $option -eq 4 ]]
    then
        list=$(pgrep dontstarve)
        if [[ $list == "" ]]
        then
            announce_message "$msgnotrunning"
        else
            announce_message "$msgrunning"
        fi
    
    elif [[ $option -eq 5 ]]
    then
        shift $#
        mode=0
    else
        echo "$promptinvalid$option"
    fi
done

read -p "$promptenter"
