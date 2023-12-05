#!/bin/bash

#export DISPLAY=:0
#export QT_QPA_PLATFORM=xcb
#export XAUTHORITY=/home/pi/.Xauthority
#export QT_DEBUG_PLUGINS=1

xhost + local:
unclutter -idle 0

/usr/bin/python3 /home/<user>/RelayController-RPi/main.py
