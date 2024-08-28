#!/bin/bash

##################
# PAT QRV MODULE #
##################
MODULE="PAT"

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
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/save-pat.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-pat.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/config_${QRV_PROFILE}.json ]; then
	cp $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/config_${QRV_PROFILE}.json $HOME/.config/pat/config.json
elif [ -f $QRV_PROFILE_DIR/DEFAULT/$MODULE/config_DEFAULT.json ]; then
	cp $QRV_PROFILE_DIR/DEFAULT/$MODULE/config_DEFAULT.json $HOME/.config/pat/config.json
fi

sed -i "s/\"locator\": .*,$/\"locator\": \"$MYLOC\",/" $HOME/.config/pat/config.json

if [ -f $SAVE_DIR/rmslist.json ]; then
	ln -sf $SAVE_DIR/rmslist.json $HOME/.local/share/pat/rmslist.json
else
	cp $HOME/.local/share/pat/rmslist.json $SAVE_DIR/rmslist.json
	rm $HOME/.local/share/pat/rmslist.json
	ln -s $SAVE_DIR/rmslist.json $HOME/.local/share/pat/rmslist.json
fi

for mailbox in archive in out sent; do
	mkdir -p $SAVE_DIR/$mailbox
   	unlink $HOME/.local/share/pat/mailbox/$MYCALL/$mailbox 2> /dev/null
   	rm -rf $HOME/.local/share/pat/mailbox/$MYCALL/$mailbox    	
	ln -sTf $SAVE_DIR/$mailbox $HOME/.local/share/pat/mailbox/$MYCALL/$mailbox
done

sudo systemctl restart pat@$USER.service

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
