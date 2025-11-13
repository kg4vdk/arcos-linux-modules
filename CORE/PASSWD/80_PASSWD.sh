#!/bin/bash

#####################
# PASSWD QRV MODULE #
#####################
MODULE="PASSWD"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

### USERS MAY GENERATE A PASSWD FILE BY RUNNING:
### `openssl passwd -1 supersecretpasword > /arcHIVE/QRV/CALLSIGN/.passwd`

if [ -f $ARCOS_DATA/QRV/$MYCALL/.passwd ]; then
	sudo usermod --password $(cat $ARCOS_DATA/QRV/$MYCALL/.passwd) user
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
