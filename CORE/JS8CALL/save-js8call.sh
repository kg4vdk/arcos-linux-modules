#!/bin/bash

MODULE="JS8CALL"

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

js8call_save () {
if [ -f $SAVE_DIR/JS8Call.ini ]; then
	mv $SAVE_DIR/JS8Call.ini $SAVE_DIR/JS8Call_$(date +"%Y%m%d%H%M%Z").ini
	cp $HOME/.config/JS8Call.ini $SAVE_DIR/JS8Call.ini
else
	cp $HOME/.config/JS8Call.ini $SAVE_DIR/JS8Call.ini
fi
}

if js8call_save; then
	notify-send --icon=js8call-custom-icon "JS8CALL" "Configuration saved!"
else
	notify-send --icon=error "JS8CALL" "Error saving configuration!"
fi
