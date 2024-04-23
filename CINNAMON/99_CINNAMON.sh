#!/bin/bash

#######################
# CINNAMON QRV MODULE #
#######################
MODULE="CINNAMON"

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

#jq --arg new "remove-this-one.desktop" '."pinned-apps"."value" -= [$new]' $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org/2.json > /tmp/2.json

#mv /tmp/2.json $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org/2.json

#jq --arg new "add-this-one.desktop" '."pinned-apps"."value" += [$new]' $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org/2.json > /tmp/2.json

#mv /tmp/2.json $HOME/.config/cinnamon/spices/grouped-window-list@cinnamon.org/2.json

dbus-send --type=method_call --dest=org.Cinnamon /org/Cinnamon org.Cinnamon.Eval string:"global.real_restart()"

sleep 2

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
