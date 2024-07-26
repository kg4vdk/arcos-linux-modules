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
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/COMMUNITY/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

notify-send --icon=gnome-break-timer "Deploying $MODULE Module..." "Please be patient."

sudo dpkg -i $MODULE_DIR/packages/*.deb

sudo cp $MODULE_DIR/nginx.conf /etc/nginx/nginx.conf
sudo cp $MODULE_DIR/sites-available/default /etc/nginx/sites-available/default
sudo rm -rf /var/www/html
sudo cp -r $MODULE_DIR/html /var/www/
sudo chown -R www-data:www-data /var/www/html
sudo mkdir /var/www/html/items
sudo chown -R www-data:www-data /var/www/html/items
sudo systemctl restart nginx.service
sudo cp $MODULE_DIR/generate-parade-csv.sh /opt/arcOS/bin/generate-parade-csv.sh
sudo chmod +x /opt/arcOS/bin/generate-parade-csv.sh
sudo cp $MODULE_DIR/rsync-parade-items.sh /opt/arcOS/bin/rsync-parade-items.sh
sudo chmod +x /opt/arcOS/bin/rsync-parade-items.sh
echo "* * * * * user /opt/arcOS/bin/rsync-parade-items.sh" | sudo tee --append /etc/crontab
cp $MODULE_DIR/generate-parade-csv.desktop $HOME/Desktop/
cp $MODULE_DIR/parade-web-interface.desktop $HOME/Desktop/



} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
