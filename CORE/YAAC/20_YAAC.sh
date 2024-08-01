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

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p $SAVE_DIR

YAAC_DIR=$HOME/.YAAC
YAAC_PROFILE_DIR=$HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles
YAAC_PROFILE=$SAVE_DIR/yaac-profile

mkdir -p $YAAC_DIR

if [ -d $YAAC_PROFILE ]; then
    rm -rf $YAAC_PROFILE_DIR/arcOS && cp -r $YAAC_PROFILE $YAAC_PROFILE_DIR/arcOS
fi

mkdir -p $ARCOS_DATA/QRV/offline-maps
rm -rf $YAAC_DIR/tiledir
ln -sTf $ARCOS_DATA/QRV/offline-maps $YAAC_DIR/tiledir

mkdir -p $MODULE_DIR/logdir
rm -rf $YAAC_DIR/logdir
ln -sTf $MODULE_DIR/logdir $YAAC_DIR/logdir

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
