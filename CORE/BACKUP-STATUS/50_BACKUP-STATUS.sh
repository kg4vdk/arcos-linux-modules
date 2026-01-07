#!/bin/bash

############################
# BACKUP-STATUS QRV MODULE #
############################
MODULE="BACKUP-STATUS"

# STATION INFO
source $HOME/.station-info

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
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log

