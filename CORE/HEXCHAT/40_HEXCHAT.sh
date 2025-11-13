#!/bin/bash

######################
# HEXCHAT QRV MODULE #
######################
MODULE="HEXCHAT"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

killall hexchat > /dev/null 2>&1

mkdir -p $HOME/.config/hexchat
cp $MODULE_DIR/hexchat.conf $HOME/.config/hexchat/
cp $MODULE_DIR/servlist.conf $HOME/.config/hexchat/

sed -i "s/XXXCALLSIGNXXX/${MYCALL}/g" $HOME/.config/hexchat/servlist.conf

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
