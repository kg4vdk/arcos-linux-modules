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
	cp ${MODULE_DIR}/config/viking.prefs $HOME/.config/viking/
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

