#!/bin/bash

###########################
# CUSTOM-ICONS QRV MODULE #
###########################
MODULE="BAND-CONDITIONS-CONKY"

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

if [ ! -d ${SAVE_DIR}/custom-icons ]; then
    cp -r ${MODULE_DIR}/custom-icons ${SAVE_DIR}/
fi

cp -a ${SAVE_DIR}/custom-icons/* $HOME/.local/share/icons/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

