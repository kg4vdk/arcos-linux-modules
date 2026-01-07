#!/bin/bash

######################
# FIREFOX QRV MODULE #
######################
MODULE="FIREFOX"

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

if grep "mozilla" /etc/mtab; then
	sudo umount $HOME/.mozilla
fi

rm -rf $HOME/.mozilla
mkdir -p $HOME/.mozilla

if [ ! -f $SAVE_DIR/mozilla-fs ]; then
	dd if=/dev/zero of=$SAVE_DIR/mozilla-fs bs=1M count=512
	mkfs.ext4 $SAVE_DIR/mozilla-fs
	sudo mount $SAVE_DIR/mozilla-fs $HOME/.mozilla
	sudo chown user:user $HOME/.mozilla
	sudo chmod 700 $HOME/.mozilla
	sudo umount $HOME/.mozilla
fi

sudo mount $SAVE_DIR/mozilla-fs $HOME/.mozilla

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

