#!/bin/bash

###################
# YAAC QRV MODULE #
###################
MODULE="YAAC"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

yaac_save () {
QRV_PROFILE=$(echo "${QRV_PROFILE}" | tr '[:lower:]' '[:upper:]' | sed 's/|//')

if [ -d $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/yaac-profile_${QRV_PROFILE} ]; then
	mv $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/yaac-profile_${QRV_PROFILE} $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/yaac-profile_${QRV_PROFILE}_$(date +"%F_%H%M")
	cp -r $HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles/arcOS $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/yaac-profile_${QRV_PROFILE}
else
	mkdir -p $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE
	cp -r $HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles/arcOS $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/yaac-profile_${QRV_PROFILE}
fi
}

QRV_PROFILE_LIST="^DEFAULT$(for profile in $(ls /arcHIVE/QRV/${MYCALL}/SAVED/PROFILES 2> /dev/null); do echo -n "!$profile"; done)"

QRV_PROFILE=$(yad --title="Save to QRV Profile" \
--window-icon="checkbox-qt" \
--form --borders=36 \
--center \
--fixed \
--field="QRV Profile":CBE "${QRV_PROFILE_LIST}" \
--text="Select (or create) the QRV Profile where the configuration will be saved.\n" \
--buttons-layout=end)

if echo "${QRV_PROFILE}" | grep "|" > /dev/null; then
	if yaac_save; then
		notify-send --icon=yaac-custom-icon "YAAC" "Configuration saved!"
	else
		notify-send --icon=error "YAAC" "Error saving configuration!"
	fi
fi
