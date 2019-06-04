#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./bin/easyscreen.sh silent "DST-main-overworld" "~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-main/bin/dontstarve_dedicated_server_nullrenderer" -cluster Main -shard Overworld
./bin/easyscreen.sh silent "DST-main-caves" "~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-main/bin/dontstarve_dedicated_server_nullrenderer" -cluster Main -shard Caves

read -p "Press Enter to Close"
