#!/bin/bash

MODULE="FL-SUITE"

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

fl_suite_save () {
if [ -f $SAVE_DIR/fl-suite.tgz ]; then
	mv $SAVE_DIR/fl-suite.tgz $SAVE_DIR/fl-suite_$(date +"%Y%m%d%H%M%Z").tgz
	tar -C $HOME -czf $SAVE_DIR/fl-suite.tgz .fldigi .nbems
else
	tar -C $HOME -czf $SAVE_DIR/fl-suite.tgz .fldigi .nbems
fi
}

if fl_suite_save; then
	notify-send --icon=fldigi-custom-icon "FL-SUITE" "Configuration saved!"
else
	notify-send --icon=error "FL-SUITE" "Error saving configuration!"
fi
