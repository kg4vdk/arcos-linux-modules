#!/bin/bash

####################
# SOUND QRV MODULE #
####################
MODULE="SOUND"

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
SAVE_DIR=$ARCOS_DATA/QRV/.${MODULE}
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

MACHINE_SERIAL=$(sudo dmidecode -s system-serial-number)

sound_save () {

mkdir -p $SAVE_DIR
alsactl store -f $SAVE_DIR/alsa_${MACHINE_SERIAL}.state

}

if sound_save; then
	notify-send --icon=sound "SOUND" "Configuration saved!"
else
	notify-send --icon=error "SOUND" "Error saving configuration!"
fi
