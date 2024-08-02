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

# PATHS
ARCOS_DATA=/media/$USER/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/save-pat.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-pat.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

if [ -f $SAVE_DIR/config.json ]; then
	cp $SAVE_DIR/config.json $HOME/.config/pat/config.json
fi

if [ -f $SAVE_DIR/rmslist.json ]; then
	ln -sf $SAVE_DIR/rmslist.json $HOME/.local/share/pat/rmslist.json
else
	cp $HOME/.local/share/pat/rmslist.json $SAVE_DIR/rmslist.json
	rm $HOME/.local/share/pat/rmslist.json
	ln -s $SAVE_DIR/rmslist.json $HOME/.local/share/pat/rmslist.json
fi

for mailbox in archive in out sent; do
    rm -rf $HOME/.local/share/pat/mailbox/$MYCALL/$mailbox
    mkdir -p $SAVE_DIR/$mailbox
    ln -sTf $SAVE_DIR/$mailbox $HOME/.local/share/pat/mailbox/$MYCALL/$mailbox
done

sudo systemctl restart pat@$USER.service

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
