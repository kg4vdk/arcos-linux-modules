#!/bin/bash

######################
# FIREFOX QRV MODULE #
######################
MODULE="FIREFOX"

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

mkdir -p $SAVE_DIR/mozilla/firefox-esr/arcOS.profile
if grep "mozilla" /etc/mtab; then
	sudo umount $HOME/.mozilla
fi

rm -rf $HOME/.mozilla
mkdir -p $HOME/.mozilla
sudo mount --bind $SAVE_DIR/mozilla $HOME/.mozilla

#mkdir -p $SAVE_DIR

#mkdir -p $SAVE_DIR/arcOS.profile
#mkdir -p $HOME/.mozilla/firefox-esr
#ln -sTf $SAVE_DIR/arcOS.profile $HOME/.mozilla/firefox-esr/arcOS.profile
} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

