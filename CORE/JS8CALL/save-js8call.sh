#!/bin/bash

######################
# JS8CALL QRV MODULE #
######################
MODULE="JS8CALL"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

js8call_save () {
QRV_PROFILE=$(echo "${QRV_PROFILE}" | tr '[:lower:]' '[:upper:]' | sed 's/|//')

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/JS8Call_${QRV_PROFILE}.ini ]; then
	mv $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/JS8Call_${QRV_PROFILE}.ini $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/JS8Call_${QRV_PROFILE}_$(date +"%F_%H%M").ini
	cp $HOME/.config/JS8Call.ini $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/JS8Call_${QRV_PROFILE}.ini
else
	mkdir -p $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE
	cp $HOME/.config/JS8Call.ini $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/JS8Call_${QRV_PROFILE}.ini
fi
}

QRV_PROFILE_LIST="^DEFAULT$(for profile in $(ls /ARCOS-DATA/QRV/${MYCALL}/SAVED/PROFILES 2> /dev/null); do echo -n "!$profile"; done)"

QRV_PROFILE=$(yad --title="Save to QRV Profile" \
--window-icon="checkbox-qt" \
--form --borders=36 \
--center \
--fixed \
--field="QRV Profile":CBE "${QRV_PROFILE_LIST}" \
--text="Select (or create) the QRV Profile where the configuration will be saved.\n" \
--buttons-layout=end)

if echo "${QRV_PROFILE}" | grep "|" > /dev/null; then
	if js8call_save; then
		notify-send --icon=js8call-custom-icon "JS8CALL" "Configuration saved!"
	else
		notify-send --icon=error "JS8CALL" "Error saving configuration!"
	fi
fi
