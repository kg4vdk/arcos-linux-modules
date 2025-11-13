#!/bin/bash

##########################
# TOR-BROWSER QRV MODULE #
##########################
MODULE="TOR-BROWSER"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

pkill -f firefox.real > /dev/null 2>&1

if [ -f ${MODULE_DIR}/tor-browser/start-tor-browser.desktop ]; then
	cd ${MODULE_DIR}/tor-browser
	${MODULE_DIR}/tor-browser/start-tor-browser.desktop --register-app
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

