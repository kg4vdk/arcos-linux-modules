#!/bin/bash

#####################
# VIKING QRV MODULE #
#####################
MODULE="VIKING"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p $SAVE_DIR

mkdir -p $SAVE_DIR/config
unlink $HOME/.config/viking
rm -rf $HOME/.config/viking
ln -sTf $SAVE_DIR/config $HOME/.config/viking

if [ ! -f $HOME/.config/viking/viking.prefs ]; then
	cp /opt/arcOS/configs/viking/viking.prefs $HOME/.config/viking/
fi

if [ ! -f $HOME/.config/maps.xml ]; then
	cp /opt/arcOS/configs/viking/maps.xml $HOME/.config/viking/
fi

if [ ! -f $HOME/.config/viking_layer_defaults.ini ]; then
	cp /opt/arcOS/configs/viking/viking_layer_defaults.ini $HOME/.config/viking/
fi

mkdir -p ${ARCOS_DATA}/QRV/OFFLINE-MAPS/viking/mapnik

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

