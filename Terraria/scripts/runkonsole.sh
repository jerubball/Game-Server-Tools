#!/bin/bash

cd ./tshock_4.3.25

nohup konsole --new-tab -p tabtitle="Tshock" -e nice -n -5 ./TerrariaServer.exe &>/dev/null &
read -p "Press Enter to continue."
