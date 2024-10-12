#!/bin/bash

######################
# HEXCHAT QRV MODULE #
######################
MODULE="HEXCHAT"

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
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

killall hexchat > /dev/null 2>&1

mkdir -p $HOME/.config/hexchat
cp $MODULE_DIR/hexchat.conf $HOME/.config/hexchat/
cp $MODULE_DIR/servlist.conf $HOME/.config/hexchat/

sed -i "s/XXXCALLSIGNXXX/${MYCALL}/g" $HOME/.config/hexchat/servlist.conf

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $MODULE_DIR/PIDGIN.log 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
