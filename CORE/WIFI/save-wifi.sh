#!/bin/bash

MODULE="WIFI"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE

mkdir -p $SAVE_DIR

wifi_save () {
WIFI_CONNS="$(sudo grep -l "type=wifi" /run/NetworkManager/system-connections/netplan*.nmconnection)"
sudo cp $WIFI_CONNS $SAVE_DIR/
}

if wifi_save; then
	notify-send --icon=network-wireless "WIFI" "Configuration saved!"
else
	notify-send --icon=error "WIFI" "Error saving configuration!"
fi