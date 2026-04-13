#!/bin/bash

####################
# GNUPG QRV MODULE #
####################
MODULE="GNUPG"

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

if grep "gnupg" /etc/mtab; then
	sudo umount $HOME/.gnupg
fi

rm -rf $HOME/.gnupg
mkdir -p $HOME/.gnupg

if [ ! -f $SAVE_DIR/gnupg-fs ]; then
	dd if=/dev/zero of=$SAVE_DIR/gnupg-fs bs=1M count=16
	mkfs.ext4 $SAVE_DIR/gnupg-fs
	sudo mount $SAVE_DIR/gnupg-fs $HOME/.gnupg
	sudo chown user:user $HOME/.gnupg
	sudo chmod 700 $HOME/.gnupg
	sudo umount $HOME/.gnupg
fi

sudo mount $SAVE_DIR/gnupg-fs $HOME/.gnupg

gpgconf --kill gpg-agent

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

