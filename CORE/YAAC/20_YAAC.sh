#!/bin/bash

###################
# YAAC QRV MODULE #
###################
MODULE="YAAC"

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
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/save-yaac.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-yaac.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

YAAC_DIR=$HOME/.YAAC
YAAC_PROFILE_DIR=$HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles

if [ -d $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/yaac-profile_${QRV_PROFILE} ]; then
	YAAC_PROFILE=$QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/yaac-profile_${QRV_PROFILE}
else
	YAAC_PROFILE=$QRV_PROFILE_DIR/DEFAULT/$MODULE/yaac-profile_DEFAULT
fi

mkdir -p $YAAC_DIR

if [ -d $YAAC_PROFILE ]; then
    rm -rf $YAAC_PROFILE_DIR/arcOS && cp -r $YAAC_PROFILE $YAAC_PROFILE_DIR/arcOS
fi

mkdir -p $ARCOS_DATA/QRV/OFFLINE-MAPS
unlink $YAAC_DIR/tiledir 2> /dev/null
rm -rf $YAAC_DIR/tiledir
ln -sTf $ARCOS_DATA/QRV/OFFLINE-MAPS $YAAC_DIR/tiledir

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
