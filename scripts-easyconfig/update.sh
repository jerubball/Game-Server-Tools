#!/bin/sh

sudo /home/steam/steamcmd +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +force_install_dir /home/steam/steamapps/DST +app_update 343050 validate +quit

cd /home/steam/steamapps/DST/mods

cp --force ./dedicated_server_mods_setup.backup.lua ./dedicated_server_mods_setup.lua

cd /home/steam/steamapps/DST/bin

sudo ./dontstarve_dedicated_server_nullrenderer -only_update_server_mods -conf_dir DoNotStarveTogether_EasyConfig -cluster Cluster_1
sudo ./dontstarve_dedicated_server_nullrenderer -only_update_server_mods -conf_dir DoNotStarveTogether_EasyConfig -cluster Cluster_914469371
