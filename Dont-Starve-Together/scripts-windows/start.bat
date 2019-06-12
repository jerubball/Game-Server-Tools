@ECHO OFF

set SteamAppId=322330
set SteamGameId=322330

cd "C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together Dedicated Server\bin"
start "Don't Starve Together Overworld" "dontstarve_dedicated_server_nullrenderer.exe" -cluster Beta -shard Overworld -console
start "Don't Starve Together Caves"     "dontstarve_dedicated_server_nullrenderer.exe" -cluster Beta -shard Caves -console

