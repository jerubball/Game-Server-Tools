#!/bin/sh

steamcmd +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +app_info_update 1 +app_info_print 343050 +quit | grep "AppID : 343050," > ~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-main/changenumber

steamcmd +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +force_install_dir ~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-main +app_update 343050 validate +quit
#steamcmd +login anonymous +force_install_dir ~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-main +app_update 343050 validate +quit

cd ~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-main/mods
cp --force ./dedicated_server_mods_setup.backup.lua ./dedicated_server_mods_setup.lua

cd ~/.steam/SteamApps/common/Dont-Starve-Together-Dedicated-Server-main/bin
./dontstarve_dedicated_server_nullrenderer -only_update_server_mods
