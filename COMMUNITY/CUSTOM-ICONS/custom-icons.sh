#!/bin/bash

MODULE="CUSTOM-ICONS"

MYCALL=$(head -n 1 $HOME/.station-info)
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE

# Hex color value (without the leading '#')
HEX_COLOR="$1"
TINT="$2"
if [[ "$3" == "invert" ]]; then
	INVERT="true"
fi

for icon in ${MODULE_DIR}/base-icons/*.png; do
	if [[ "${INVERT}" == "true" ]]; then
		HEX_COLOR_INVERT="$(echo "${HEX_COLOR}" | tr "0123456789abcdef" "fedcba9876543210")"
		mkdir -p ${MODULE_DIR}/custom-icons-${HEX_COLOR}-inverted/hicolor/48x48/apps
		convert $icon -colorspace rgb -fill "#${HEX_COLOR_INVERT}" -tint ${TINT} -negate ${MODULE_DIR}/custom-icons-${HEX_COLOR}-inverted/$(basename $icon)
	else
		mkdir -p ${MODULE_DIR}/custom-icons-${HEX_COLOR}/hicolor/48x48/apps
		convert $icon -colorspace rgb -fill "#${HEX_COLOR}" -tint ${TINT} ${MODULE_DIR}/custom-icons-${HEX_COLOR}/$(basename $icon)
	fi
done

if [[ "${INVERT}" == "true" ]]; then
	mv ${MODULE_DIR}/custom-icons-${HEX_COLOR}-inverted/F302_VARA.0.png ${MODULE_DIR}/custom-icons-${HEX_COLOR}-inverted/hicolor/48x48/apps/F302_VARA.0.png
	mv ${MODULE_DIR}/custom-icons-${HEX_COLOR}-inverted/C497_VARAFM.0.png ${MODULE_DIR}/custom-icons-${HEX_COLOR}-inverted/hicolor/48x48/apps/C497_VARAFM.0.png
else
	mv ${MODULE_DIR}/custom-icons-${HEX_COLOR}/F302_VARA.0.png ${MODULE_DIR}/custom-icons-${HEX_COLOR}/hicolor/48x48/apps/F302_VARA.0.png
	mv ${MODULE_DIR}/custom-icons-${HEX_COLOR}/C497_VARAFM.0.png ${MODULE_DIR}/custom-icons-${HEX_COLOR}/hicolor/48x48/apps/C497_VARAFM.0.png
fi	
	
	
	
	
	
