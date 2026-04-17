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

SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
mkdir -p $SAVE_DIR

if [ ! -f $SAVE_DIR/arcOS-Field-Manual.html ]; then
    sudo cp $MODULE_DIR/arcOS-Field-Manual.html /opt/arcOS/
else
    sudo cp $SAVE_DIR/arcOS-Field-Manual.html /opt/arcOS/
fi
cp $MODULE_DIR/arcOS-Field-Manual.desktop $HOME/.local/share/applications/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
