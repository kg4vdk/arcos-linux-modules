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
SAVE_DIR=$ARCOS_DATA/QRV/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p $SAVE_DIR

mkdir -p $HOME/.config/evolution/sources
mkdir -p $HOME/.local/share/evolution/calendar/arcOS

cp $MODULE_DIR/sources/birthdays.source $HOME/.config/evolution/sources/
cp $MODULE_DIR/sources/system-calendar.source $HOME/.config/evolution/sources/
cp $MODULE_DIR/sources/arcOS.source $HOME/.config/evolution/sources/

if [ -f $SAVE_DIR/calendar.ics ]; then
	cp $SAVE_DIR/calendar.ics $HOME/.local/share/evolution/calendar/arcOS/
fi

gsettings set org.gnome.Evolution.DefaultSources default-calendar 'arcOS'

if ! grep "calendar.ics" /etc/crontab; then
	echo "* * * * * user /usr/bin/rsync --checksum /home/user/.local/share/evolution/calendar/arcOS/calendar.ics $SAVE_DIR/calendar.ics" | sudo tee --append /etc/crontab
fi
} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
