#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./bin/easyscreen.sh silent "Minecraft" java -jar -Xmx1500M -Xms500M server.jar

read -p "Press Enter to Close"
