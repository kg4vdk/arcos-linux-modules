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

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

ardop_save () {
QRV_PROFILE=$(echo "${QRV_PROFILE}" | tr '[:lower:]' '[:upper:]' | sed 's/|//')

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/ardopcf_${QRV_PROFILE} ]; then
	mv $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/ardopcf_${QRV_PROFILE} $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/ardopcf_${QRV_PROFILE}_$(date +"%F_%H%M")
	cp /opt/arcOS/bin/ardopcf $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/ardopcf_${QRV_PROFILE}
else
	mkdir -p $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE
	cp /opt/arcOS/bin/ardopcf $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/ardopcf_${QRV_PROFILE}
fi
}

QRV_PROFILE_LIST="^DEFAULT$(for profile in $(ls /media/$USER/ARCOS-DATA/QRV/${MYCALL}/SAVED/PROFILES 2> /dev/null); do echo -n "!$profile"; done)"

QRV_PROFILE=$(yad --title="Save to QRV Profile" \
--window-icon="checkbox-qt" \
--form --borders=36 \
--center \
--fixed \
--field="QRV Profile":CBE "${QRV_PROFILE_LIST}" \
--text="Select (or create) the QRV Profile where the configuration will be saved.\n" \
--buttons-layout=end \
--undecorated)

if echo "${QRV_PROFILE}" | grep "|" > /dev/null; then
	if ardop_save; then
		notify-send --icon=ardop-custom-icon "ARDOP" "Configuration saved!"
	else
		notify-send --icon=error "ARDOP" "Error saving configuration!"
	fi
fi
