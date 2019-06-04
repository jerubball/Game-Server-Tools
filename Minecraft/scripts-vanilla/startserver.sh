#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./bin/easyscreen.sh silent "Minecraft" java -jar server.jar

read -p "Press Enter to Close"
