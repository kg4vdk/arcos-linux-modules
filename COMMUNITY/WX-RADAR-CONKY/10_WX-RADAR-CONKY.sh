#!/bin/bash

################### USER DEFINED VARIABLES ###################

# Define NWS Radar Station (e.g. KOHX), or leave empty for national map
# https://www.roc.noaa.gov/branches/program-branch/site-id-database/site-id-location-maps.php
NWS_STATION=""

# Sizes available: large, medium, small, tiny, tiny-integrated
SIZE="tiny-integrated"

################# END USER DEFINED VARIABLES ################

#############################
# WX-RADAR-CONKY QRV MODULE #
#############################
MODULE="WX-RADAR-CONKY"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp ${MODULE_DIR}/bin/get-wx-radar.sh /opt/arcOS/bin/

sudo sed -i "s/XXXNWSSTATIONXXX/${NWS_STATION}/" /opt/arcOS/bin/get-wx-radar.sh

# If NWS Station is empty use the national map
if [ "${NWS_STATION}" == "" ]; then
	NWS_STATION="CONUS"
fi

# Set image sizes
case $SIZE in

  large)
    if [ "${NWS_STATION}" == "CONUS" ]; then
		XXX="600"
		YYY="392"
	else
		XXX="600"
		YYY="550"
	fi
    ;;

  medium)
    if [ "${NWS_STATION}" == "CONUS" ]; then
		XXX="480"
		YYY="314"
	else
		XXX="480"
		YYY="440"
	fi
    ;;

  small)
    if [ "${NWS_STATION}" == "CONUS" ]; then
		XXX="420"
		YYY="274"
	else
		XXX="420"
		YYY="385"
	fi
    ;;
    
  tiny)
    if [ "${NWS_STATION}" == "CONUS" ]; then
		XXX="220"
		YYY="144"
	else
		XXX="220"
		YYY="202"
	fi
    ;;
    
  tiny-integrated)
    INTEGRATED="true"
    if [ "${NWS_STATION}" == "CONUS" ]; then
		XXX="220"
		YYY="144"
	else
		XXX="220"
		YYY="202"
	fi
    ;;

  *)
    INTEGRATED="true"
    if [ "${NWS_STATION}" == "CONUS" ]; then
		XXX="220"
		YYY="144"
	else
		XXX="220"
		YYY="202"
	fi
    ;;
esac


# Add to cron downloading image every minute
cat << EOF | sudo tee --append /etc/crontab
*/2 * * * * user /opt/arcOS/bin/get-wx-radar.sh
EOF

# Restart cron
sudo systemctl restart cron.service

# Download first image if network is reachable
if ping -c 1 radar.weather.gov; then
	/opt/arcOS/bin/get-wx-radar.sh
fi

# Kill any already running WX conky
pkill -f "wx-conkyrc"

# # Create config and place in /tmp
cp ${MODULE_DIR}/config/wx-conkyrc /tmp/wx-conkyrc
sed -i "s/XXX/${XXX}/" /tmp/wx-conkyrc
sed -i "s/YYY/${YYY}/" /tmp/wx-conkyrc
if [ "${INTEGRATED}" == "true" ]; then
	sed -i "s/alignment = 'top_right'/alignment = 'bottom_right'/" /tmp/wx-conkyrc
	sed -i "s/gap_y = 5/gap_y = 425/" /tmp/wx-conkyrc
fi

# Start WX conky
conky -c /tmp/wx-conkyrc -qd

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

