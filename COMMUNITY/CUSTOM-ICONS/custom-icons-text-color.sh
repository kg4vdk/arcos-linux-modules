#!/bin/bash

MODULE="CUSTOM-ICONS"

MYCALL=$(head -n 1 $HOME/.station-info)
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE

CUSTOM_ICONS="$1"
TEXT_COLOR="$2"

mkdir -p ${MODULE_DIR}/custom-icons-${CUSTOM_ICONS}-text/hicolor/48x48/apps
for icon in $(find ${MODULE_DIR}/custom-icons-${CUSTOM_ICONS} -type f -name "*.png"); do
	convert $icon -colorspace rgb -fuzz 20% -fill "#${TEXT_COLOR}" -opaque black ${MODULE_DIR}/custom-icons-${CUSTOM_ICONS}-text/$(basename $icon)
done

mv ${MODULE_DIR}/custom-icons-${CUSTOM_ICONS}-text/F302_VARA.0.png ${MODULE_DIR}/custom-icons-${CUSTOM_ICONS}-text/hicolor/48x48/apps/F302_VARA.0.png
mv ${MODULE_DIR}/custom-icons-${CUSTOM_ICONS}-text/C497_VARAFM.0.png ${MODULE_DIR}/custom-icons-${CUSTOM_ICONS}-text/hicolor/48x48/apps/C497_VARAFM.0.png
	
	
	
	
