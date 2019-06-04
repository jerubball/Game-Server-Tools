#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./main/easyscreen.sh status "DST-main-overworld"
./main/easyscreen.sh status "DST-main-caves"

read -p "Press Enter to Close"
