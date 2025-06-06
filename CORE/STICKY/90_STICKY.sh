#!/bin/bash

#####################
# STICKY QRV MODULE #
#####################
MODULE="STICKY"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p $SAVE_DIR/sticky

if [ ! -f $SAVE_DIR/sticky/notes.json ]; then
	cp ${MODULE_DIR}/config/notes.json $SAVE_DIR/sticky/
	sed -i "s/XXXCALLSIGNXXX/$MYCALL/" $SAVE_DIR/sticky/notes.json
fi

unlink $HOME/.config/sticky
rm -rf $HOME/.config/sticky
ln -sTf $SAVE_DIR/sticky $HOME/.config/sticky

gsettings set org.x.sticky autostart-notes-visible true
gsettings set org.x.sticky default-position 'center-center'
gsettings set org.x.sticky show-in-tray true
gsettings set org.x.sticky show-manager false

sticky &

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

