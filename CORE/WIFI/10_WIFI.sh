#!/bin/bash

###################
# WIFI QRV MODULE #
###################
MODULE="WIFI"

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

sudo cp $MODULE_DIR/save-wifi.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-wifi.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

WIFI_DEVICE=$(iwconfig 2> /dev/null | grep wl | awk -F " " '{print $1}')
if ls $SAVE_DIR/*.nmconnection &>/dev/null; then
    for nmconnection in $SAVE_DIR/*.nmconnection; do
        sed -i "s/^interface-name=.*$/interface-name=$WIFI_DEVICE/" "$nmconnection"
        sudo cp "$nmconnection" /etc/NetworkManager/system-connections/
        sudo chmod 600 /etc/NetworkManager/system-connections/*.nmconnection
    done
    sudo systemctl daemon-reload
    sudo systemctl restart NetworkManager.service
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

