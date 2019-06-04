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


if [[ "$(screen -ls "DST-main" | grep "DST-main")" == "" ]]
then
    server=1
else
    server=0
fi

message=""

if [[ $server == 0 ]]
then
    message="Don't Starve Together main server is running!"
else
    message="Don't Starve Together main server **not** running!"
fi

version=$(cat ~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-main/version.txt || echo "")
current=$(cat ~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-main/changenumber || echo "")
update=$(/home/steam/steamcmd +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +app_info_update 1 +app_info_print 343050 +quit | grep "AppID : 343050,")
if [[ $current == $update ]]
then
    statusupdate="Server is up-to-date."
else
    statusupdate="Server is outdated."
fi

statusversion="\tVersion : $version, $current\`"
statusversion=${statusversion//: /: \`}
statusversion=${statusversion//, /\`, $'\n\t'}
message="$message$newline$statusupdate$newline$statusversion"

echo "$message"
announce_message "$message"

read -p "Press Enter to Close"

