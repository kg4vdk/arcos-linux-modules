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
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

if [ -f $MODULE_DIR/config.json ]; then
	cp $MODULE_DIR/config.json $HOME/.config/pat/config.json
fi

if [ -f $MODULE_DIR/rmslist.json ]; then
	ln -sf $MODULE_DIR/rmslist.json $HOME/.local/share/pat/rmslist.json
else
	cp $HOME/.local/share/pat/rmslist.json $MODULE_DIR/rmslist.json
	rm $HOME/.local/share/pat/rmslist.json
	ln -s $MODULE_DIR/rmslist.json $HOME/.local/share/pat/rmslist.json
fi

for mailbox in archive in out sent; do
    rm -rf $HOME/.local/share/pat/mailbox/$MYCALL/$mailbox
    mkdir -p $MODULE_DIR/$mailbox
    ln -sTf $MODULE_DIR/$mailbox $HOME/.local/share/pat/mailbox/$MYCALL/$mailbox
done

sudo systemctl restart pat@$USER.service

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
