#!/bin/bash
# https://github.com/noodlebox/stream-announcer

set -e

prompt="[Announce] Choose: (T) Start, (P) Stop, (R) Restart, (U) Status, (V) Version, (X) Exit"
promptenter="Press Enter to continue."
promptinvalid="Invalid option: "
#color = (r << 16) + (g << 8) + b
#id='WEBHOOK_ID'
#token='WEBHOOK_TOKEN'
#url="https://discordapp.com/api/webhooks/$id/$token"
#url=""
servername="Don't Starve Together Dedicated Server"
msgstart=" started."
msgstop=" stopped."
msgrestart=" is restarting."
msgrunning=" is currently running,"
msgnotrunning=" is currently closed,"
msguptodate=" and is up-to-date."
msgoutdated=" and is outdated. Update is on the way."
msgappend=$'\n**`Server time: '
username='Server Status'

webhook_post() {
	curl --header 'Content-Type: application/json' --data-raw "$(</dev/fd/0)" "$1"
}

webhook_encode() {
	jq -c -n --arg content "$1" --arg username "$2" --argjson embeds "$(</dev/fd/0)" '{$content, $username, $embeds}'
}

announce_message() {
	webhook_encode "$1$msgappend$(date)\`**" "$username" <<<'[]' | webhook_post "$url"
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
        elif [[ $option = "v" || $option = "version" ]]
        then
            option=5
        elif [[ $option = "x" || $option = "exit" ]]
        then
            option=6
        fi
    fi
    
    if [[ $option -eq 1 ]]
    then
        announce_message "$servername$msgstart"
        
    elif [[ $option -eq 2 ]]
    then
        announce_message "$servername$msgstop"
    
    elif [[ $option -eq 3 ]]
    then
        announce_message "$servername$msgrestart"
        
    elif [[ $option -eq 4 ]]
    then
        list=$(pgrep dontstarve || echo "")
        if [[ $list == "" ]]
        then
            statusrun="$msgnotrunning"
        else
            statusrun="$msgrunning"
        fi
        
        current=$(cat /home/steam/steamapps/DST/changenumber || echo "")
        update=$(/home/steam/steamcmd +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +app_info_update 1 +app_info_print 343050 +quit | grep "AppID : 343050,")
        if [[ $current == $update ]]
        then
            statusupdate="$msguptodate"
        else
            statusupdate="$msgoutdated"
        fi
        
        announce_message "$servername$statusrun$statusupdate"
        
    elif [[ $option -eq 5 ]]
    then
        version=$(cat /home/steam/steamapps/DST/version.txt || echo "")
        current=$(cat /home/steam/steamapps/DST/changenumber || echo "")
        string="version : $version, $current"
        string=${string//: /: \`}
        string=${string//, /\`, $'\n\t'}
        announce_message "$servername has $string\`"
        
    elif [[ $option -eq 6 ]]
    then
        shift $#
        mode=0
    else
        echo "$promptinvalid$option"
    fi
done

read -p "$promptenter"
