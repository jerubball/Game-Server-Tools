#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ../../Dont-Starve-Together-Dedicated-Server-beta/bin
../../bin/beta/easyscreen.sh silent "DST-beta-overworld" "./dontstarve_dedicated_server_nullrenderer" -cluster Beta -shard Overworld
../../bin/beta/easyscreen.sh silent "DST-beta-caves" "./dontstarve_dedicated_server_nullrenderer" -cluster Beta -shard Caves

read -p "Press Enter to Close"
