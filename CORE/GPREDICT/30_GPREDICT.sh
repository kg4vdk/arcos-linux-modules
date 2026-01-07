#!/bin/bash

#######################
# GPREDICT QRV MODULE #
#######################
MODULE="GPREDICT"

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

mkdir -p $SAVE_DIR

mkdir -p $SAVE_DIR/Gpredict
unlink $HOME/.config/Gpredict
rm -rf $HOME/.config/Gpredict
ln -sTf $SAVE_DIR/Gpredict $HOME/.config/Gpredict

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

