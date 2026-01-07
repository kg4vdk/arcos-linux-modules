#!/bin/bash

####################
# SOUND QRV MODULE #
####################
MODULE="SOUND"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

MACHINE_SERIAL=$(sudo dmidecode -s system-serial-number | sed 's/ /_/g')

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/save-sound.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-sound.desktop $HOME/.local/share/applications/

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/alsa_${MACHINE_SERIAL}_${QRV_PROFILE}.state ]; then
	ALSA_CONFIG=$QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/alsa_${MACHINE_SERIAL}_${QRV_PROFILE}.state
else
	ALSA_CONFIG=$QRV_PROFILE_DIR/DEFAULT/$MODULE/alsa_${MACHINE_SERIAL}_DEFAULT.state
fi

if [ -f $ALSA_CONFIG ]; then
	alsactl restore -f $ALSA_CONFIG
else
	if arecord -l | grep "card 5" | grep USB; then
		amixer -c 5 set Mic Capture 5
	fi
fi
} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
