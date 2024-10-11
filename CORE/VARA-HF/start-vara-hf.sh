#!/bin/bash

gnome-terminal --geometry=80x10 --class=vara.exe --hide-menubar --title="RIGCTLD" --zoom=0.75 -- sh -c 'echo "RIGCTLD for VARA-HF...\nLeave open while using VARA-HF."; rigctld --model=1 --ptt-file=/dev/digirig --ptt-type=RTS' &

sudo systemctl restart pat@user.service

sleep 1

env WINEPREFIX="/home/user/.wine_varahf_32" wine /home/user/.wine_varahf_32/drive_c/VARA/VARA.exe > /dev/null 2>&1 &
