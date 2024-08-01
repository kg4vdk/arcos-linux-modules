#!/bin/bash

MODULE="YAAC"

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
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE

mkdir -p $SAVE_DIR

if [ -d $SAVE_DIR/yaac-profile ]; then
	mv $SAVE_DIR/yaac-profile $SAVE_DIR/yaac-profile_$(date +"%Y%m%d%H%M%Z")
	cp -r $HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles/arcOS $SAVE_DIR/yaac-profile
else
	cp -r $HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles/arcOS $SAVE_DIR/yaac-profile
fi
