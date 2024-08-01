#!/bin/bash

#######################
# FL-SUITE QRV MODULE #
#######################
MODULE="FL-SUITE"

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

mkdir -p $SAVE_DIR

FL_SUITE_CONFIG=$SAVE_DIR/fl-suite.tgz

if [ -f $FL_SUITE_CONFIG ]; then
	tar -C $HOME -xzf $FL_SUITE_CONFIG
fi

mkdir -p $SAVE_DIR/{logs,FLAMP,ICS}
mkdir -p $SAVE_DIR/FLAMP/{rx,tx,scripts}
mkdir -p $SAVE_DIR/ICS/{messages,templates}
mkdir -p $SAVE_DIR/CUSTOM

rm -rf $HOME/.fldigi/logs $HOME/.nbems/FLAMP/{rx,tx,scripts} $HOME/.nbems/ICS/{messages,templates} $HOME/.nbems/CUSTOM

ln -sTF $SAVE_DIR/logs $HOME/.fldigi/logs
ln -sTF $SAVE_DIR/FLAMP/rx $HOME/.nbems/FLAMP/rx
ln -sTF $SAVE_DIR/FLAMP/tx $HOME/.nbems/FLAMP/tx
ln -sTF $SAVE_DIR/FLAMP/scripts $HOME/.nbems/FLAMP/scripts
ln -sTF $SAVE_DIR/ICS/messages $HOME/.nbems/ICS/messages
ln -sTF $SAVE_DIR/ICS/templates $HOME/.nbems/ICS/templates
ln -sTF $SAVE_DIR/CUSTOM $HOME/.nbems/CUSTOM

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
