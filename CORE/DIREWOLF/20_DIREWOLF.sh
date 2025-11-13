#!/bin/bash

#######################
# DIREWOLF QRV MODULE #
#######################
MODULE="DIREWOLF"

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

sudo cp $MODULE_DIR/save-direwolf.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-direwolf.desktop $HOME/.local/share/applications/

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/direwolf_${QRV_PROFILE}.conf ]; then
	DIREWOLF_CONFIG=$QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/direwolf_${QRV_PROFILE}.conf
else
	DIREWOLF_CONFIG=$QRV_PROFILE_DIR/DEFAULT/$MODULE/direwolf_DEFAULT.conf
fi

if [ -f $DIREWOLF_CONFIG ]; then
	cp $DIREWOLF_CONFIG $HOME/.config/direwolf.conf
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
