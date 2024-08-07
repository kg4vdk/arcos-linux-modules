#!/bin/bash

######################
# JS8CALL QRV MODULE #
######################
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
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/save-js8call.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-js8call.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

if [ -f $SAVE_DIR/JS8Call.ini ]; then
	cp $SAVE_DIR/JS8Call.ini $HOME/.config/JS8Call.ini
fi

mkdir -p $SAVE_DIR/JS8Call
rm -rf $HOME/.local/share/JS8Call
ln -sTf $SAVE_DIR/JS8Call $HOME/.local/share/JS8Call

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
