#!/bin/bash

##################
# SSH QRV MODULE #
##################
MODULE="SSH"

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

if grep "ssh" /etc/mtab; then
	sudo umount $HOME/.ssh
fi

rm -rf $HOME/.ssh
mkdir -p $HOME/.ssh

if [ ! -f $SAVE_DIR/ssh-fs ]; then
	dd if=/dev/zero of=$SAVE_DIR/ssh-fs bs=1M count=128
	mkfs.ext4 $SAVE_DIR/ssh-fs
	sudo mount $SAVE_DIR/ssh-fs $HOME/.ssh
	sudo chown user:user $HOME/.ssh
	sudo chmod 755 $HOME/.ssh
	sudo umount $HOME/.ssh
fi

sudo mount $SAVE_DIR/ssh-fs $HOME/.ssh

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

