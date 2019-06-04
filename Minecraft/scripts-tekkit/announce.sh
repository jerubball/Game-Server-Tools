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


if [[ "$(screen -ls "Tekkit" | grep "Tekkit")" == "" ]]
then
    server=1
else
    server=0
fi

if [[ "$(screen -ls "ngrok" | grep "ngrok")" == "" ]]
then
    ngrok=1
else
    ngrok=0
fi

message=""

if [[ $server == 0 ]]
then
    message="Minecraft Tekkit Server is running!"
else
    message="Minecraft Tekkit Server is **not** running!"
fi

if [[ $ngrok == 0 ]]
then
    link="$(curl http://192.168.163.219:4040/api/tunnels/tekkit | jq -r '.public_url')"
    message="${message}${newline}Port forwarding service is running!${newline}Address: \`${link/tcp:\/\/}\`"
else
    message="${message}${newline}Port forwarding service is **not** running!"
fi

if [[ $server == 0 ]]
then
    status="$(mcstatus 192.168.163.219:25567 query)"
    message="${message}${newline}${newline}$(echo "$status" | head -n 2 | tail -n 1 | grep -oE "^software: v[0-9].[0-9].[0-9]")${newline}$(echo "$status" | grep -oE "^players: [0-9]+/[0-9]+")"
fi

echo "$message"
announce_message "$message"

read -p "Press Enter to Close"

