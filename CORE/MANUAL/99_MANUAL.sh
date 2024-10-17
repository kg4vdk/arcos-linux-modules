#!/bin/bash

#####################
# MANUAL QRV MODULE #
#####################
MODULE="MANUAL"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

cp $MODULE_DIR/arcOS-Field-Manual.pdf $HOME/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
