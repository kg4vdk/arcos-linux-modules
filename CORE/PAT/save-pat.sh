#!/bin/bash

MODULE="PAT"

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

pat_save () {
if [ -f $SAVE_DIR/config.json ]; then
	mv config.json  $SAVE_DIR/config_$(date +"%Y%m%d%H%M%Z").json
	cp $HOME/.config/pat/config.json $SAVE_DIR/config.json 
else
	cp $HOME/.config/pat/config.json $SAVE_DIR/config.json
fi
}

if pat_save; then
	notify-send --icon=pat-custom-icon "PAT WLNK" "Configuration saved!"
else
	notify-send --icon=error "PAT WLNK" "Error saving configuration!"
fi

