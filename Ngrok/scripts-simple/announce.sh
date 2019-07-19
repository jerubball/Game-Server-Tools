#!/bin/bash

url="https://discordapp.com/api/webhooks/526137136869539853/JX_2Xga83yEZn4eafVnep1ozRzC9DNuDp2NV4n0clGuc2u0IBHgL_rdunzccDJepXwP0"
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

if [[ "$(screen -ls "ngrok" | grep "ngrok")" == "" ]]
then
    ngrok=1
else
    ngrok=0
fi

message=""

if [[ $ngrok == 0 ]]
then
    link=($(curl http://192.168.163.219:4040/api/tunnels | jq -r '.tunnels[]|(.name, .public_url)'))
    size=${#link[@]}
    message="Port forwarding service is running!"
    for (( i=0 ; i<size ; i+=2 ))
    do
        message="${message}${newline}${link[i]}'s address: \`${link[i+1]/tcp:\/\/}\`"
    done
else
    message="Port forwarding service is **not** running!"
fi

echo "$message"
announce_message "$message"

read -p "Press Enter to Close"

