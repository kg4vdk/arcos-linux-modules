#!/bin/bash

####################
# QSSTV QRV MODULE #
####################
MODULE="QSSTV"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp $MODULE_DIR/save-qsstv.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-qsstv.desktop $HOME/.local/share/applications/
mkdir -p $SAVE_DIR

if [ -f $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/qsstv_9.0_${QRV_PROFILE}.conf ]; then
	cp $QRV_PROFILE_DIR/${QRV_PROFILE}/$MODULE/qsstv_9.0_${QRV_PROFILE}.conf $HOME/.config/ON4QZ/qsstv_9.0.conf
elif [ -f $QRV_PROFILE_DIR/DEFAULT/$MODULE/qsstv_9.0_DEFAULT.conf ]; then
	cp $QRV_PROFILE_DIR/DEFAULT/$MODULE/qsstv_9.0_DEFAULT.conf $HOME/.config/ON4QZ/qsstv_9.0.conf
fi

mkdir -p $HOME/.qsstv
for directory in audio rx tx templates; do
	mkdir -p $SAVE_DIR/$directory
   	unlink $HOME/.qsstv/$directory 2> /dev/null
   	rm -rf $HOME/.qsstv/$directory    	
	ln -sTf $SAVE_DIR/$directory $HOME/.qsstv/$directory
done

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
