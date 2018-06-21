#!/bin/bash

cd /home/steam/steamapps/DST/bin

nohup konsole --new-tab -p tabtitle="Overworld" -e nice -n -10 ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether_EasyConfig -cluster Cluster_1 &>/dev/null &
nohup konsole --new-tab -p tabtitle="Caves" -e nice -n -10 ./dontstarve_dedicated_server_nullrenderer -conf_dir DoNotStarveTogether_EasyConfig -cluster Cluster_914469371 &>/dev/null &
read -p "Press Enter to continue."
