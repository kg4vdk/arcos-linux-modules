#!/bin/bash

###################
# ADSB QRV MODULE #
###################
MODULE="ADSB"

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

sudo unlink /usr/share/skyaware/html/mapnik
sudo ln -s ${ARCOS_DATA}/QRV/OFFLINE-MAPS/viking/mapnik /usr/share/skyaware/html/mapnik

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

