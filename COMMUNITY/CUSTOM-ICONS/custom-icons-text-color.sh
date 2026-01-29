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

CUSTOM_ICONS="$1"
TEXT_COLOR="$2"

mkdir -p ${SAVE_DIR}/custom-icons-${CUSTOM_ICONS}-text/hicolor/48x48/apps
for icon in $(find ${SAVE_DIR}/custom-icons-${CUSTOM_ICONS} -type f -name "*.png"); do
	convert $icon -colorspace rgb -fuzz 20% -fill "#${TEXT_COLOR}" -opaque black ${SAVE_DIR}/custom-icons-${CUSTOM_ICONS}-text/$(basename $icon)
done

mv ${SAVE_DIR}/custom-icons-${CUSTOM_ICONS}-text/F302_VARA.0.png ${SAVE_DIR}/custom-icons-${CUSTOM_ICONS}-text/hicolor/48x48/apps/F302_VARA.0.png
mv ${SAVE_DIR}/custom-icons-${CUSTOM_ICONS}-text/C497_VARAFM.0.png ${SAVE_DIR}/custom-icons-${CUSTOM_ICONS}-text/hicolor/48x48/apps/C497_VARAFM.0.png
	
	
	
	
