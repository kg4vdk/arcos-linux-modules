#!/bin/bash

#####################
# WSJT-X QRV MODULE #
#####################
MODULE="WSJT-X"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

if [ -f $MODULE_DIR/WSJT-X.ini ]; then
	cp $MODULE_DIR/WSJT-X.ini $HOME/.config/WSJT-X.ini
fi

mkdir -p $MODULE_DIR/WSJT-X
rm -rf $HOME/.local/share/WSJT-X
ln -sTf $MODULE_DIR/WSJT-X $HOME/.local/share/WSJT-X

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
