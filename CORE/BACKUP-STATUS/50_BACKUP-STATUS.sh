#!/bin/bash

############################
# BACKUP-STATUS QRV MODULE #
############################
MODULE="BACKUP-STATUS"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

sudo cp ${MODULE_DIR}/bin/backup-operator.sh /opt/arcOS/bin/

LAST_BKP_FILE="${ARCOS_DATA}/QRV/${MYCALL}/.last-backup"

pkill -f backup-conkyrc

sed "s/XXXCALLSIGNXXX/${MYCALL}/g" ${MODULE_DIR}/config/backup-conkyrc > $HOME/.backup-conkyrc

conky -qd -c $HOME/.backup-conkyrc &

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

