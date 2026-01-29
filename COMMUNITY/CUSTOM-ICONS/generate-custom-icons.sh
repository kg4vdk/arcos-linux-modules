#!/bin/bash

#########################
# GENERATE-CUSTOM-ICONS #
#########################
MODULE="CUSTOM-ICONS"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

mkdir -p ${SAVE_DIR}

# Hex color value (without the leading '#')
HEX_COLOR="$1"
TINT="$2"
if [[ "$3" == "invert" ]]; then
	INVERT="true"
fi

for icon in ${MODULE_DIR}/base-icons/*.png; do
	if [[ "${INVERT}" == "true" ]]; then
		HEX_COLOR_INVERT="$(echo "${HEX_COLOR}" | tr "0123456789abcdef" "fedcba9876543210")"
		mkdir -p ${SAVE_DIR}/custom-icons-${HEX_COLOR}-inverted/hicolor/48x48/apps
		convert $icon -colorspace rgb -fill "#${HEX_COLOR_INVERT}" -tint ${TINT} -negate ${SAVE_DIR}/custom-icons-${HEX_COLOR}-inverted/$(basename $icon)
	else
		mkdir -p ${SAVE_DIR}/custom-icons-${HEX_COLOR}/hicolor/48x48/apps
		convert $icon -colorspace rgb -fill "#${HEX_COLOR}" -tint ${TINT} ${SAVE_DIR}/custom-icons-${HEX_COLOR}/$(basename $icon)
	fi
done

if [[ "${INVERT}" == "true" ]]; then
	mv ${SAVE_DIR}/custom-icons-${HEX_COLOR}-inverted/F302_VARA.0.png ${SAVE_DIR}/custom-icons-${HEX_COLOR}-inverted/hicolor/48x48/apps/F302_VARA.0.png
	mv ${SAVE_DIR}/custom-icons-${HEX_COLOR}-inverted/C497_VARAFM.0.png ${SAVE_DIR}/custom-icons-${HEX_COLOR}-inverted/hicolor/48x48/apps/C497_VARAFM.0.png
else
	mv ${SAVE_DIR}/custom-icons-${HEX_COLOR}/F302_VARA.0.png ${SAVE_DIR}/custom-icons-${HEX_COLOR}/hicolor/48x48/apps/F302_VARA.0.png
	mv ${SAVE_DIR}/custom-icons-${HEX_COLOR}/C497_VARAFM.0.png ${SAVE_DIR}/custom-icons-${HEX_COLOR}/hicolor/48x48/apps/C497_VARAFM.0.png
fi	
	
	
	
	
	
