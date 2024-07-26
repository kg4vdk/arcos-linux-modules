#!/bin/bash

########################
# CHALLENGE QRV MODULE #
########################
MODULE="CHALLENGE"

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

if [ -f /tmp/coords.log ]; then
	LATITUDE="$(head -n 1 /tmp/coords.log | awk -F "," '{print $1}' | xargs printf "%.5f\n")"
	LONGITUDE="$(head -n 1 /tmp/coords.log | awk -F "," '{print $2}' | xargs printf "%.5f\n")"
else
	LATITUDE="00.00000"
	LONGITUDE="00.00000"
fi

sudo dpkg -i $MODULE_DIR/packages/*.deb

cp $MODULE_DIR/direwolf.conf $HOME/.config/direwolf.conf
sed -i "s/XXXCALLSIGNXXX/$MYCALL/" $HOME/.config/direwolf.conf
MYCALLPHONETIC=$($MODULE_DIR/call2nato.sh $MYCALL | sed 's/ /, /g')
sed -i "s/XXXCBEACONINFOXXX/${MYCALLPHONETIC}/" $HOME/.config/direwolf.conf
sed -i "s/XXXLATITUDEXXX/${LATITUDE}/" $HOME/.config/direwolf.conf
sed -i "s/XXXLONGITUDEXXX/${LONGITUDE}/" $HOME/.config/direwolf.conf
sudo cp $MODULE_DIR/dwespeak.sh /opt/arcOS/bin/
sudo cp $MODULE_DIR/aprstt.sh /opt/arcOS/bin/
sudo cp $MODULE_DIR/call2nato.sh /opt/arcOS/bin/
sudo cp $MODULE_DIR/challenge-times.sh /opt/arcOS/bin/
sudo cp $MODULE_DIR/start-challenge.sh /opt/arcOS/bin/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
