#!/bin/bash

~/him-get.sh -n -k easyscreen.sh
clear
chmod +x easyscreen.sh
cd ..
./bin/easyscreen.sh start "ngrok" ./ngrok start minecraft forge tekkit

read -p "Press Enter to Close"
