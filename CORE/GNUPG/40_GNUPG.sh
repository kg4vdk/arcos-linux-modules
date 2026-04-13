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

# Identify and define the boot device and persistent partition
BOOT_DEV="$(df -h | grep cdrom | awk -F " " '{print $1}')"
if [[ $BOOT_DEV == *"nvme"* ]]; then
	DISK=${BOOT_DEV%??}
	EXFAT_PARTITION="p3"
elif [[ $BOOT_DEV == *"mmcblk"* ]]; then
    DISK=${BOOT_DEV%??}
	EXFAT_PARTITION="p3"
else
	DISK=${BOOT_DEV%?}
	EXFAT_PARTITION="3"
fi

if [ ! -f $SAVE_DIR/gnupg-fs ]; then
	if [ "${BOOT_DEV}" != "/dev/shm" ] && [ "${BOOT_DEV}" != "/dev/sr0" ] && [ "${BOOT_DEV}" != "/dev/mapper/ventoy" ]; then
		dd if=/dev/zero of=$SAVE_DIR/gnupg-fs bs=1M count=16
		mkfs.ext4 $SAVE_DIR/gnupg-fs
		sudo mount $SAVE_DIR/gnupg-fs $HOME/.gnupg
		sudo chown user:user $HOME/.gnupg
		sudo chmod 700 $HOME/.gnupg
	fi
else
	sudo mount $SAVE_DIR/gnupg-fs $HOME/.gnupg
fi

gpgconf --kill gpg-agent

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

