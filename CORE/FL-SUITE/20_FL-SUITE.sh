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

sudo cp $MODULE_DIR/save-fl-suite.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-fl-suite.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/fl-suite_${QRV_PROFILE}.tgz ]; then
	FL_SUITE_CONFIG=$QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/fl-suite_${QRV_PROFILE}.tgz
else
	FL_SUITE_CONFIG=$QRV_PROFILE_DIR/DEFAULT/$MODULE/fl-suite_DEFAULT.tgz
fi

if [ -f $FL_SUITE_CONFIG ]; then
	tar -C $HOME -xzf $FL_SUITE_CONFIG
fi

mkdir -p $SAVE_DIR/{logs,FLAMP,ICS}
mkdir -p $SAVE_DIR/FLAMP/{rx,tx,scripts}
mkdir -p $SAVE_DIR/ICS/{messages,templates}
mkdir -p $SAVE_DIR/CUSTOM

unlink $HOME/.fldigi/logs 2> /dev/null
unlink $HOME/.nbems/FLAMP/rx 2> /dev/null
unlink $HOME/.nbems/FLAMP/tx 2> /dev/null
unlink $HOME/.nbems/FLAMP/scripts 2> /dev/null
unlink $HOME/.nbems/ICS/messages 2> /dev/null
unlink $HOME/.nbems/ICS/templates 2> /dev/null
unlink $HOME/.nbems/CUSTOM 2> /dev/null
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
