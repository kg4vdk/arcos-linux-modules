#!/bin/bash

####################
# ARDOP QRV MODULE #
####################
MODULE="ARDOP"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/save-ardop.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-ardop.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/start-ardop_${QRV_PROFILE} ]; then
	ARDOP_CONFIG=$QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/start-ardop_${QRV_PROFILE}
else
	ARDOP_CONFIG=$QRV_PROFILE_DIR/DEFAULT/$MODULE/start-ardop_DEFAULT
fi

if [ -f $ARDOP_CONFIG ]; then
	sudo cp $ARDOP_CONFIG /opt/arcOS/bin/start-ardop
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
