#!/bin/bash

###################
# ADSB QRV MODULE #
###################
MODULE="ADSB"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/COMMUNITY/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

notify-send --icon=gnome-break-timer "Deploying $MODULE Module..." "Please be patient."

sudo dpkg -i $MODULE_DIR/packages/*.deb

sudo piaware-config use-gpsd yes

sudo cp $MODULE_DIR/config/89-skyaware.conf /etc/lighttpd/conf-enabled/

sudo cp $MODULE_DIR/config/script.js /usr/share/skyaware/html/

sudo cp $MODULE_DIR/config/planeObject.js /usr/share/skyaware/html/

sudo systemctl daemon-reload

sudo systemctl restart lighttpd.service

cp $MODULE_DIR/applications/adsb.desktop $HOME/Desktop/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
