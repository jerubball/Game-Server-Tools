#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ../../Dont-Starve-Together-Dedicated-Server-main/bin
../../bin/main/easyscreen.sh silent "DST-main-overworld" "./dontstarve_dedicated_server_nullrenderer" -cluster Main -shard Overworld
../../bin/main/easyscreen.sh silent "DST-main-caves" "./dontstarve_dedicated_server_nullrenderer" -cluster Main -shard Caves

read -p "Press Enter to Close"
