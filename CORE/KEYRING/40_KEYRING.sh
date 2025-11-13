#!/bin/bash

######################
# KEYRING QRV MODULE #
######################
MODULE="KEYRING"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p $SAVE_DIR

if grep "keyring" /etc/mtab; then
	sudo umount $HOME/.local/share/keyrings
fi

rm -rf $HOME/.local/share/keyrings
mkdir -p $HOME/.local/share/keyrings

if [ ! -f $SAVE_DIR/keyring-fs ]; then
	dd if=/dev/zero of=$SAVE_DIR/keyring-fs bs=1M count=128
	mkfs.ext4 $SAVE_DIR/keyring-fs
	sudo mount $SAVE_DIR/keyring-fs $HOME/.local/share/keyrings
	sudo chown user:user $HOME/.local/share/keyrings
	sudo chmod 700 $HOME/.local/share/keyrings
	sudo umount $HOME/.local/share/keyrings
fi

sudo mount $SAVE_DIR/keyring-fs $HOME/.local/share/keyrings

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

