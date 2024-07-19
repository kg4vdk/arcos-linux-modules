#!/bin/bash

#!/bin/bash

############################
# APRSD-WEBCHAT QRV MODULE #
############################
MODULE="APRSD-WEBCHAT"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/${MYCALL}/arcos-linux-modules/COMMUNITY/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

PKGS=$(find $MODULE_DIR/packages -maxdepth 0 -empty -exec echo "empty" \;)
PIP=$(find $MODULE_DIR/pip -maxdepth 0 -empty -exec echo "empty" \;)

local_install () {
	sudo dpkg -i $MODULE_DIR/packages/*.deb
	pip install --no-index --find-links $MODULE_DIR/pip aprsd
	mkdir -p $HOME/.config/aprsd
	cp $MODULE_DIR/aprsd.yml $HOME/.config/aprsd/
	sed -i "s/XXXCALLSIGNXXX/${MYCALL}/" $HOME/.config/aprsd/aprsd.yml
	if [ -f /tmp/coords.log ]; then
		LATITUDE=$(cat /tmp/coords.log | awk -F "," '{print $1}')
		LONGITUDE=$(cat /tmp/coords.log | awk -F "," '{print $2}')
		sed -i "s/XXXLATITUDEXXX/${LATITUDE}/" $HOME/.config/aprsd/aprsd.yml
		sed -i "s/XXXLONGITUDEXXX/${LONGITUDE}/" $HOME/.config/aprsd/aprsd.yml
	else
		sed -i "s/^.*XXXLATITUDEXXX/#&/" $HOME/.config/aprsd/aprsd.yml
		sed -i "s/^.*XXXLONGITUDEXXX/#&/" $HOME/.config/aprsd/aprsd.yml
	fi
	sudo cp $MODULE_DIR/start-aprsd-webchat /opt/arcOS/bin/
	cp $MODULE_DIR/start-aprsd-webchat.desktop $HOME/Desktop/
}

if [ ${PKGS} != "empty" ] || [ ${PIP} != "empty" ]; then
	notify-send --icon=gnome-break-timer "$MODULE" "$MODULE is being installed. Please be patient..."
	local_install
else
	if ping -c 1 8.8.8.8 > /dev/null; then
		notify-send --icon=gnome-break-timer "$MODULE" "$MODULE is being installed. Please be patient..."
  		mkdir -p $MODULE_DIR/{packages,pip}
		sudo apt clean
		sudo apt install -y --download-only python3-pip
		cp /var/cache/apt/archives/*.deb $MODULE_DIR/packages/
		sudo dpkg -i $MODULE_DIR/packages/*.deb
		pip download aprsd==3.2.2 --dest $MODULE_DIR/pip
		local_install
	else
		echo "Internet connection required for first run setup."
		notify-send --icon=error "$MODULE" "$MODULE requires internet access on the first run!"
	fi
fi



} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
