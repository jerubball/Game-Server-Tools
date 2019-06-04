#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./bin/easyscreen.sh stop "DST-beta-overworld"
./bin/easyscreen.sh stop "DST-beta-caves"

read -p "Press Enter to Close"
