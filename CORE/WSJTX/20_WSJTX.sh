#!/bin/bash

####################
# WSJTX QRV MODULE #
####################
MODULE="WSJTX"

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
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/save-wsjtx.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-wsjtx.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/WSJT-X_${QRV_PROFILE}.ini ]; then
	cp $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/WSJT-X_${QRV_PROFILE}.ini $HOME/.config/WSJT-X.ini
elif [ -f $QRV_PROFILE_DIR/DEFAULT/$MODULE/WSJT-X_DEFAULT.ini ]; then
	cp $QRV_PROFILE_DIR/DEFAULT/$MODULE/WSJT-X_DEFAULT.ini $HOME/.config/WSJT-X.ini
fi

sed -i "s/MyGrid=.*$/MyGrid=$MYLOC/" $HOME/.config/WSJT-X.ini

mkdir -p $SAVE_DIR/WSJT-X
unlink $HOME/.local/share/WSJT-X 2> /dev/null
rm -rf $HOME/.local/share/WSJT-X
ln -sTf $SAVE_DIR/WSJT-X $HOME/.local/share/WSJT-X

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
