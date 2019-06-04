#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./bin/easyscreen.sh silent "Tekkit" /usr/lib/jvm/java-8-openjdk-amd64/bin/java -jar Tekkit.jar

read -p "Press Enter to Close"
