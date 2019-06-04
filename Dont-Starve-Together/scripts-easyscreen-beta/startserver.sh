#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./bin/easyscreen.sh silent "DST-beta-overworld" "~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-beta/bin/dontstarve_dedicated_server_nullrenderer" -cluster Beta -shard Overworld
./bin/easyscreen.sh silent "DST-beta-caves" "~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-beta/bin/dontstarve_dedicated_server_nullrenderer" -cluster Beta -shard Caves

read -p "Press Enter to Close"
