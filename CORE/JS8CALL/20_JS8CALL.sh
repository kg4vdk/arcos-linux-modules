#!/bin/bash

######################
# JS8CALL QRV MODULE #
######################
MODULE="JS8CALL"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/save-js8call.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-js8call.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/JS8Call_${QRV_PROFILE}.ini ]; then
	cp $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/JS8Call_${QRV_PROFILE}.ini $HOME/.config/JS8Call.ini
elif [ -f $QRV_PROFILE_DIR/DEFAULT/$MODULE/JS8Call_DEFAULT.ini ]; then
	cp $QRV_PROFILE_DIR/DEFAULT/$MODULE/JS8Call_DEFAULT.ini $HOME/.config/JS8Call.ini
fi

sed -i "s/MyGrid=.*$/MyGrid=$MYLOC/" $HOME/.config/JS8Call.ini

mkdir -p $SAVE_DIR/JS8Call
unlink $HOME/.local/share/JS8Call 2> /dev/null
rm -rf $HOME/.local/share/JS8Call
ln -sTf $SAVE_DIR/JS8Call $HOME/.local/share/JS8Call

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
