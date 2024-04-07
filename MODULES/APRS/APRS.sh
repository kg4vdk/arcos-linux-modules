#!/bin/bash

###################
# APRS QRV MODULE #
###################
MODULE="APRS"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/MODULES/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

YAAC_DIR=$HOME/YAAC
YAAC_PROFILE_DIR=$HOME/.java/.userPrefs/org/ka2ddo/yaac/Profiles
YAAC_PROFILE=$MODULE_DIR/yaac-profile.tgz

mkdir -p $YAAC_DIR

if [ -f $YAAC_PROFILE ]; then
    rm -rf $YAAC_PROFILE_DIR/arcOS && tar -C $YAAC_PROFILE_DIR -xzf $YAAC_PROFILE
fi

mkdir -p $MODULE_DIR/tiledir
rm -rf $YAAC_DIR/tiledir
ln -sTf $MODULE_DIR/tiledir $YAAC_DIR/tiledir

mkdir -p $MODULE_DIR/logdir
rm -rf $YAAC_DIR/logdir
ln -sTf $MODULE_DIR/logdir $YAAC_DIR/logdir

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
