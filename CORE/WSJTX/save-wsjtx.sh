#!/bin/bash

MODULE="WSJTX"

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

wsjtx_save () {
if [ -f $SAVE_DIR/WSJT-X.ini ]; then
	mv $SAVE_DIR/WSJT-X.ini $SAVE_DIR/WSJT-X_$(date +"%Y%m%d%H%M%Z").ini
	cp $HOME/.config/WSJT-X.ini $SAVE_DIR/WSJT-X.ini
else
	cp $HOME/.config/WSJT-X.ini $SAVE_DIR/WSJT-X.ini
fi
}

if wsjtx_save; then
	notify-send --icon=wsjtx-custom-icon "WSJTX" "Configuration saved!"
else
	notify-send --icon=error "WSJTX" "Error saving configuration!"
fi
