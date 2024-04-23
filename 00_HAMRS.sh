#!/bin/bash

####################
# HAMRS QRV MODULE #
####################
MODULE="HAMRS"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

APPIMAGE=$(ls $MODULE_DIR/hamrs*.AppImage | tail -n 1)

sed -i "s:^Exec=.*$:Exec=$APPIMAGE --no-sandbox:" $MODULE_DIR/hamrs.desktop

cp $MODULE_DIR/hamrs.png $HOME/.icons/
cp $MODULE_DIR/hamrs.desktop $HOME/.local/share/applications/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
