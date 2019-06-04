#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./bin/easyscreen.sh silent "Forge" /usr/lib/jvm/java-8-openjdk-amd64/bin/java -jar forge-1.12.2-14.23.5.2768-universal.jar

read -p "Press Enter to Close"
