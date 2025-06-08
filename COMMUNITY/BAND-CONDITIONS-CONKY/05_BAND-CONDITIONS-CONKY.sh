#!/bin/bash

####################################
# BAND-CONDITIONS-CONKY QRV MODULE #
####################################
MODULE="BAND-CONDITIONS-CONKY"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

# Add to cron downloading image every minute
cat << EOF | sudo tee --append /etc/crontab
*/5 * * * * user /usr/bin/wget -O /tmp/conditions.gif https://www.hamqsl.com/solar100sc.php?back=transparent && /usr/bin/convert /tmp/conditions.gif /tmp/conditions.png || rm /tmp/conditions.gif; rm /tmp/conditions.png
EOF

# Restart cron
sudo systemctl restart cron.service

# Download first image if network is reachable
if ping -c 5 -n 8.8.8.8; then
	wget -O /tmp/conditions.gif https://www.hamqsl.com/solar100sc.php?back=transparent
	convert /tmp/conditions.gif /tmp/conditions.png
fi

# Kill any already running WX conky
pkill -f "conditions-conkyrc"

# # Create config and place in /tmp
cp ${MODULE_DIR}/config/conditions-conkyrc /tmp/conditions-conkyrc

# Start WX conky
conky -c /tmp/conditions-conkyrc -qd

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

