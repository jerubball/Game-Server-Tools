#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./beta/easyscreen.sh stop "DST-beta-overworld"
./beta/easyscreen.sh stop "DST-beta-caves"

read -p "Press Enter to Close"
