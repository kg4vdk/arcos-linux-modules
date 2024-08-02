#!/bin/bash

MODULE="WIFI"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE

mkdir -p $SAVE_DIR

wifi_save () {
sudo cp /etc/NetworkManager/system-connections/*.nmconnection $SAVE_DIR/
}

if wifi_save; then
	notify-send --icon=js8call-custom-icon "WIFI" "Configuration saved!"
else
	notify-send --icon=error "WIFI" "Error saving configuration!"
fi
