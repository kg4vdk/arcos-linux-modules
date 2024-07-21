#!/bin/bash

######################
# PATCHES QRV MODULE #
######################
MODULE="PATCHES"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

###########################################################################

ln -sf $MODULE_DIR/configs/bash_history $HOME/.bash_history

sudo cp $MODULE_DIR/bin/start-yaac /opt/arcOS/bin/

rmdir $HOME/{Documents,Music,Pictures,Public,Templates,Videos}
echo "file:///home/user/Downloads Downloads" > $HOME/.config/gtk-3.0/bookmarks
echo "file:///media/user/ARCOS-DATA/QRV/$MYCALL/arcos-linux-modules QRV Modules" >> $HOME/.config/gtk-3.0/bookmarks

jq '."custom-format"."value" = "%a, %e %b%n%H:%M:%S %Z" | ."custom-tooltip-format"."value" = "%a, %e %b%n%H:%M %Z"' ~/.config/cinnamon/spices/calendar@cinnamon.org/13.json > /tmp/13.json && mv /tmp/13.json ~/.config/cinnamon/spices/calendar@cinnamon.org/13.json

cp $MODULE_DIR/applications/station-setup.desktop $HOME/.local/share/applications

sudo cp $MODULE_DIR/bin/update-modules /opt/arcOS/bin/

cp $MODULE_DIR/applications/update-modules.desktop $HOME/.local/share/applications

gsettings set org.cinnamon favorite-apps "['station-setup.desktop', 'update-modules.desktop', 'org.gnome.Terminal.desktop']"

gio set /media/user/ARCOS-DATA/QRV/$MYCALL/arcos-linux-modules/CORE metadata::custom-icon file:///usr/share/icons/Mint-Y-Red/places/64/folder.png
touch /media/user/ARCOS-DATA/QRV/$MYCALL/arcos-linux-modules/CORE

gio set /media/user/ARCOS-DATA/QRV/$MYCALL/arcos-linux-modules/COMMUNITY metadata::custom-icon file:///usr/share/icons/Mint-Y-Blue/places/64/folder.png
touch /media/user/ARCOS-DATA/QRV/$MYCALL/arcos-linux-modules/COMMUNITY

gio set /media/user/ARCOS-DATA/QRV/$MYCALL/arcos-linux-modules/USER metadata::custom-icon file:///usr/share/icons/Mint-Y/places/64/folder.png
touch /media/user/ARCOS-DATA/QRV/$MYCALL/arcos-linux-modules/USER

######################

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
