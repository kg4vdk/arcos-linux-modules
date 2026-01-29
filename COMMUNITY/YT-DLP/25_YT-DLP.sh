#!/bin/bash

#####################
# YT-DLP QRV MODULE #
#####################
MODULE="YT-DLP"

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

mkdir -p ${SAVE_DIR}

if [ -f /usr/bin/yt-dlp ]; then
	sudo rm /usr/bin/yt-dlp
fi

if [ -f ${SAVE_DIR}/bin/yt-dlp ]; then
	sudo ln -sf ${SAVE_DIR}/bin/yt-dlp /usr/bin/yt-dlp
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

