#!/bin/bash

#######################
# CALENDAR QRV MODULE #
#######################
MODULE="CALENDAR"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)
QRV_PROFILE=$(head -n 7 $HOME/.station-info | tail -n 1)

if [ ${QRV_PROFILE} == ${MYLOC} ]; then
	QRV_PROFILE="NONE"
fi

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

# Create calendar directories
mkdir -p $SAVE_DIR/{sources,calendar}

# Remove existing source files
rm $HOME/.config/evolution/sources/*.source

# Copy calendar source files into place
cp $MODULE_DIR/sources/{birthdays.source,system-calendar.source} $SAVE_DIR/sources/
if [ ! -f  $SAVE_DIR/sources/$MYCALL.source ]; then
	cp $MODULE_DIR/sources/user.source $SAVE_DIR/sources/$MYCALL.source
fi

# Copy initial .ics into place if needed
if [ ! -f  $SAVE_DIR/calendar/calendar.ics ]; then
	cp $MODULE_DIR/calendar/calendar.ics $SAVE_DIR/calendar/calendar.ics
fi

# Define a timestamp
TIMESTAMP=$(date +"%FT%R:%S")

# Set user calendar revision to timestamp
sed -i "s/Revision=.*$/Revision=$TIMESTAMP/" $SAVE_DIR/sources/$MYCALL.source

# Set user calendar name to callsign
sed -i "s/XXXCALLSIGNXXX/$MYCALL/g" $SAVE_DIR/sources/$MYCALL.source

# Set the evolution autoconfig directory
gsettings set org.gnome.evolution-data-server autoconfig-directory "/ARCOS-DATA/QRV/$MYCALL/SAVED/CALENDAR/sources"

# Set the default calendar
gsettings set org.gnome.Evolution.DefaultSources default-calendar "$MYCALL"

# Restart the cinnamon calendar server
cinnamon-calendar-server &

# Restart the evolution source registry
systemctl --user restart evolution-source-registry

# Restart the evolution calendar factory
systemctl --user restart evolution-calendar-factory.service

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
