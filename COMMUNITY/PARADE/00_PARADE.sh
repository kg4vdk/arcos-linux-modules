#!/bin/bash

#####################
# PARADE QRV MODULE #
#####################
MODULE="PARADE"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/COMMUNITY/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

notify-send --icon=gnome-break-timer "Deploying $MODULE Module..." "Please be patient."

sudo dpkg -i $MODULE_DIR/packages/*.deb

sudo cp $MODULE_DIR/config/nginx.conf /etc/nginx/nginx.conf
sudo cp $MODULE_DIR/config/sites-available/default /etc/nginx/sites-available/default
sudo rm -rf /var/www/html
sudo cp -r $MODULE_DIR/html /var/www/
sudo mkdir /var/www/html/items
sudo chown -R www-data:www-data /var/www/html
sudo systemctl restart nginx.service
sudo cp $MODULE_DIR/bin/*.sh /opt/arcOS/bin/
sudo chmod +x /opt/arcOS/bin/*parade*.sh

echo "* * * * * user /opt/arcOS/bin/rsync-parade-items.sh" | sudo tee --append /etc/crontab
cp $MODULE_DIR/applications/*.desktop $HOME/Desktop/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
