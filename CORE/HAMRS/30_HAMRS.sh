#!/bin/bash

####################
# HAMRS QRV MODULE #
####################
MODULE="HAMRS"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

if [ -d $ARCOS_DATA/QRV/LOGS ]; then
	if [ -f $ARCOS_DATA/QRV/LOGS/hamrs.AppImage ]; then
		mkdir -p $ARCOS_DATA/QRV/LOGS/hamrs.AppImage.home
	fi
	gio set -t stringv /$ARCOS_DATA/QRV/LOGS metadata::emblems emblem-documents
	touch /$ARCOS_DATA/QRV/LOGS
else
	mkdir -p $ARCOS_DATA/QRV/LOGS
	gio set -t stringv /$ARCOS_DATA/QRV/LOGS metadata::emblems emblem-documents
	touch /$ARCOS_DATA/QRV/LOGS
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
