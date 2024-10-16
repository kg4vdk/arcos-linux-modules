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

sudo cp $MODULE_DIR/save-hamrs.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-hamrs.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

if [ -f $SAVE_DIR/hamrs-1.0.7-linux-x86_64.AppImage.home.tgz ]; then
	tar -C $HOME/.appimages -xzf $SAVE_DIR/hamrs-1.0.7-linux-x86_64.AppImage.home.tgz
else
	mkdir -p $HOME/.appimages/hamrs-1.0.7-linux-x86_64.AppImage.home
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
