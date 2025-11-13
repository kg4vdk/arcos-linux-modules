#!/bin/bash

####################
# PANEL QRV MODULE #
####################
MODULE="PANEL"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p $SAVE_DIR

if [ -d $SAVE_DIR/grouped-window-list@cinnamon.org ]; then
	unlink $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org 2> /dev/null
	rm -rf $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org
	ln -sTf $SAVE_DIR/grouped-window-list@cinnamon.org $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org
else
	cp -r $MODULE_DIR/grouped-window-list@cinnamon.org $SAVE_DIR/
	unlink $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org 2> /dev/null
	rm -rf $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org
	ln -sTf $SAVE_DIR/grouped-window-list@cinnamon.org $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org 
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
