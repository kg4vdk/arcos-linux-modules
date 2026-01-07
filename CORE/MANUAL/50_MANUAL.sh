#!/bin/bash

#####################
# MANUAL QRV MODULE #
#####################
MODULE="MANUAL"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/arcOS-Field-Manual.html /opt/arcOS/
cp $HOME/.local/share/applications/arcOS-Field-Manual.desktop $HOME/arcOS-Field-Manual.desktop

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
