#!/bin/bash

url=""
username='Server Status'
msgappend=$'\n**`Server time: '
newline=$'\n'

webhook_post() {
	curl --header 'Content-Type: application/json' --data-raw "$(</dev/fd/0)" "$1"
}

webhook_encode() {
	jq -c -n --arg content "$1" --arg username "$2" --argjson embeds "$(</dev/fd/0)" '{$content, $username, $embeds}'
}

announce_message() {
	webhook_encode "$1$msgappend$(date)\`**" "$username" <<<'[]' | webhook_post "$url"
}


if [[ "$(screen -ls "Minecraft" | grep "Minecraft")" == "" ]]
then
    server=1
else
    server=0
fi

message=""

if [[ $server == 0 ]]
then
    message="Minecraft Server is running!"
else
    message="Minecraft Server is **not** running!"
fi

if [[ $server == 0 ]]
then
    status="$(mcstatus localhost:25565 status)"
    message="${message}${newline}${newline}$(echo "$status" | head -n 1)${newline}$(echo "$status" | grep -oE "^players: [0-9]+/[0-9]+")"
fi

echo "$message"
announce_message "$message"

read -p "Press Enter to Close"

