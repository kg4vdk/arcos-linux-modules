#!/bin/bash

##########################
# MODULES-PRE QRV MODULE #
##########################
MODULE="MODULES-PRE"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

for i in $(ls /arcHIVE/QRV/${MYCALL}/arcos-linux-modules/COMMUNITY/*_PRE_*.sh); do
	MODULE_NAME=$(basename $i)
    echo "${MODULE_NAME}"
	bash $i
done

for i in $(ls /arcHIVE/QRV/${MYCALL}/arcos-linux-modules/USER/*_PRE_*.sh); do
	MODULE_NAME=$(basename $i)
    echo "${MODULE_NAME}"
	bash $i
done

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
