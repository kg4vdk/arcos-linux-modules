#!/bin/bash

######################
# VARA-HF QRV MODULE #
######################
MODULE="VARA-HF"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

if [ ${QRV_PROFILE} == ${MYLOC} ]; then
	QRV_PROFILE="NONE"
fi

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/COMMUNITY/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

varahf_save () {
QRV_PROFILE=$(echo "${QRV_PROFILE}" | tr '[:lower:]' '[:upper:]' | sed 's/|//')

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/wine_varahf_32.tar ]; then
	mv $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/wine_varahf_32_${QRV_PROFILE}.tar $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/wine_varahf_32_${QRV_PROFILE}_$(date +"%F_%H%M").tar
else
	mkdir -p $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE
	tar -C $HOME -cf $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/wine_varahf_32_${QRV_PROFILE}.tar .wine_varahf_32
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
	if varahf_save; then
		notify-send --icon=checkbox-qt "VARA-HF" "Configuration saved!"
	else
		notify-send --icon=error "VARA-HF" "Error saving configuration!"
	fi
fi
