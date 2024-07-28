#!/bin/bash

echo "##### GENERATE DTMF CALLSIGN #####"
echo
read -p "Enter callsign: " CALLSIGN
DTMF=$(text2tt $CALLSIGN | tail -n 1)
echo "10-digit DTMF for $(echo $CALLSIGN | tr '[:lower:]' '[:upper:]'): $DTMF"
echo
read -p "Press [ENTER] to exit..." EXIT
