#!/bin/bash

####################
# PANEL QRV MODULE #
####################
MODULE="PANEL"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)
QRV_PROFILE=$(head -n 7 $HOME/.station-info | tail -n 1)

if [ ${QRV_PROFILE} == ${MYLOC} ]; then
	QRV_PROFILE="NONE"
fi

# PATHS
ARCOS_DATA=/ARCOS-DATA
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
