#!/bin/bash

######################
# WINLINK QRV MODULE #
######################
MODULE="WINLINK"

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

cp $MODULE_DIR/config.json $HOME/.config/pat/config.json

cp $MODULE_DIR/rmslist.json $HOME/.local/share/pat/rmslist.json

for mailbox in archive in out sent; do
    rm -rf $HOME/.local/share/pat/mailbox/$MYCALL/$mailbox
    mkdir -p $MODULE_DIR/$mailbox
    ln -sTf $MODULE_DIR/$mailbox $HOME/.local/share/pat/mailbox/$MYCALL/$mailbox
done

sudo systemctl restart pat@$USER.service

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
