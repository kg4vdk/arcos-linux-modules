#!/bin/bash

####################
# HAMRS QRV MODULE #
####################
MODULE="HAMRS"

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

if [ -d $ARCOS_DATA/QRV/LOGS ]; then
	if [ -f $ARCOS_DATA/QRV/LOGS/hamrs.AppImage ]; then
		mkdir -p $ARCOS_DATA/QRV/LOGS/hamrs.AppImage.home
	fi
	gio set -t stringv /$ARCOS_DATA/QRV/LOGS metadata::emblems emblem-documents
	touch /$ARCOS_DATA/QRV/LOGS
	cp ${MODULE_DIR}/applications/hamrs_system.desktop $HOME/.local/share/applications/
else
	mkdir -p $ARCOS_DATA/QRV/LOGS
	gio set -t stringv /$ARCOS_DATA/QRV/LOGS metadata::emblems emblem-documents
	touch /$ARCOS_DATA/QRV/LOGS
	if [ -f $HOME/.local/share/applications/hamrs_system.desktop ]; then
		rm $HOME/.local/share/applications/hamrs_system.desktop
	fi
fi

if [ -d $ARCOS_DATA/QRV/$MYCALL/LOGS ]; then
	if [ -f $ARCOS_DATA/QRV/$MYCALL/LOGS/hamrs.AppImage ]; then
		mkdir -p $ARCOS_DATA/QRV/$MYCALL/LOGS/hamrs.AppImage.home
	fi
	gio set -t stringv /$ARCOS_DATA/QRV/$MYCALL/LOGS metadata::emblems emblem-documents
	touch /$ARCOS_DATA/QRV/LOGS
	cp ${MODULE_DIR}/applications/hamrs_user.desktop $HOME/.local/share/applications/
	sed -i "s:^Name=.*$:Name=HAMRS ($MYCALL):" $HOME/.local/share/applications/hamrs_user.desktop
	sed -i "s:^GenericName=.*$:GenericName=HAMRS ($MYCALL):" $HOME/.local/share/applications/hamrs_user.desktop
	sed -i "s:^Comment=.*$:Comment=User specific logs:" $HOME/.local/share/applications/hamrs_user.desktop
	sed -i "s:^Exec=.*$:Exec=$ARCOS_DATA/QRV/$MYCALL/LOGS/hamrs.AppImage:" $HOME/.local/share/applications/hamrs_user.desktop
else
	mkdir -p $ARCOS_DATA/QRV/$MYCALL/LOGS
	gio set -t stringv /$ARCOS_DATA/QRV/$MYCALL/LOGS metadata::emblems emblem-documents
	touch /$ARCOS_DATA/QRV/$MYCALL/LOGS
	if [ -f $HOME/.local/share/applications/hamrs_user.desktop ]; then
		rm $HOME/.local/share/applications/hamrs_user.desktop
	fi
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
