#!/bin/bash

####################
# ARDOP QRV MODULE #
####################
MODULE="ARDOP"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)
QRV_PROFILE=$(head -n 7 $HOME/.station-info | tail -n 1)

if [ ${QRV_PROFILE} == ${MYLOC} ]; then
	QRV_PROFILE="NONE"
fi

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
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

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/ardopcf_${QRV_PROFILE} ]; then
	ARDOP_CONFIG=$QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/ardopcf_${QRV_PROFILE}
else
	ARDOP_CONFIG=$QRV_PROFILE_DIR/DEFAULT/$MODULE/ardopcf_DEFAULT
fi

if [ -f $ARDOP_CONFIG ]; then
	sudo cp $ARDOP_CONFIG /opt/arcOS/bin/ardopcf
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
