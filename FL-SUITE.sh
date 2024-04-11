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
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

FL_SUITE_CONFIG=$MODULE_DIR/fl-suite.tgz

if [ -f $FL_SUITE_CONFIG ]; then
	tar -C $HOME -xzf $FL_SUITE_CONFIG
fi

mkdir -p $MODULE_DIR/{logs,FLAMP,ICS}
mkdir -p $MODULE_DIR/FLAMP/{rx,tx}
mkdir -p $MODULE_DIR/ICS/{messages,templates}

rm -rf $HOME/.fldigi/logs $HOME/.nbems/FLAMP/{rx,tx,scripts} $HOME/.nbems/ICS/{messages,templates}

ln -sTF $MODULE_DIR/logs $HOME/.fldigi/logs
ln -sTF $MODULE_DIR/FLAMP/rx $HOME/.nbems/FLAMP/rx
ln -sTF $MODULE_DIR/FLAMP/tx $HOME/.nbems/FLAMP/tx
ln -sTF $MODULE_DIR/FLAMP/scripts $HOME/.nbems/FLAMP/scripts
ln -sTF $MODULE_DIR/ICS/messages $HOME/.nbems/ICS/messages
ln -sTF $MODULE_DIR/ICS/templates $HOME/.nbems/ICS/templates

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
