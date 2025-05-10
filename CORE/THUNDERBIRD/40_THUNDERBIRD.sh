#!/bin/bash

##########################
# THUNDERBIRD QRV MODULE #
##########################
MODULE="THUNDERBIRD"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p $SAVE_DIR

mkdir -p $SAVE_DIR/thunderbird
unlink $HOME/.thunderbird
rm -rf $HOME/.thunderbird
ln -sTf $SAVE_DIR/thunderbird $HOME/.thunderbird

#mkdir -p $SAVE_DIR
#
#if grep "thunderbird" /etc/mtab; then
#	sudo umount $HOME/.thunderbird
#fi
#
#rm -rf $HOME/.thunderbird
#mkdir -p $HOME/.thunderbird
#
#if [ ! -f $SAVE_DIR/thunderbird-fs ]; then
#	dd if=/dev/zero of=$SAVE_DIR/thunderbird-fs bs=1M count=1024
#	mkfs.ext4 $SAVE_DIR/thunderbird-fs
#	sudo mount $SAVE_DIR/thunderbird-fs $HOME/.thunderbird
#	sudo chown user:user $HOME/.thunderbird
#	sudo chmod 700 $HOME/.thunderbird
#	sudo umount $HOME/.thunderbird
#fi

#sudo mount $SAVE_DIR/thunderbird-fs $HOME/.thunderbird

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

